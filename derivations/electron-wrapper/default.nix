{
  stdenv,
  lib,
  makeWrapper,
  electron,
  asar,
  makeDesktopItem,
  copyDesktopItems,
  name ? "electron-wrapper",
  desktopName ? name,
  url ? "about:blank",
  description ? "This is a wrapper for Electron",
  icon ? null,
}:

stdenv.mkDerivation rec {
  pname = name;
  version = "1.0.4";

  src = ./.;
  dontUnpack = true;

  nativeBuildInputs = [
    makeWrapper
    asar
    copyDesktopItems
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p $out/lib/${pname}
    cp -r $src/* $out/lib/${pname}

    cat > $out/lib/${pname}/package.json <<EOF
    {
      "name": "${pname}",
      "version": "${version}",
      "main": "main.js",
      "type": "module"
    }
    EOF
    asar pack $out/lib/${pname} $out/lib/app.asar

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,share/pixmaps}

    makeWrapper "${lib.getExe electron}" "$out/bin/${pname}" \
      --add-flags $out/lib/app.asar \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}" \
      --set-default ELECTRON_IS_DEV 0 \
      --set NAME "${pname}" \
      --set DESCRIPTION "${description}" \
      --set URL "${url}" \
      --inherit-argv0

    install -Dm644 "${icon}" "$out/share/pixmaps/${pname}.png"

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = desktopName;
      categories = [ "Network" ];
      comment = meta.description;
      exec = pname;
      icon = pname;
      terminal = false;
    })
  ];

  meta = {
    description = description;
    homepage = url;
    maintainers = with lib.maintainers; [ David-Kopczynski ];
    platforms = lib.platforms.linux;
    mainProgram = name;
  };
}
