{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  home-manager.users."user".xdg.configFile."autostart/hyperhdr.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=HyperHDR
    Exec=sh ${
      pkgs.writeShellApplication {

        name = "hyperhdr-wrapper";
        runtimeInputs = with pkgs; [ hyperhdr ];
        text = ''
          # Check if running via RDP etc. by checking for :10 in DISPLAY
          if [ "''${DISPLAY#:10}" == "$DISPLAY" ]; then
            tmpfile=$(mktemp)
            echo "Starting HyperHDR..."

            # Allow capture crashes (e.g. when locking screen)
            for _ in $(seq 1 3); do
              hyperhdr --pipewire --userdata ${
                config.home-manager.users."user".xdg.configHome
              }/hyperhdr &> "$tmpfile" &
              pid=$!

              tail -F "$tmpfile" | grep -q "'no more input formats'" || true
              echo "Capture crashed."
              kill $pid || true
              wait $pid || true

              sleep 1
            done

            rm "$tmpfile"
            echo "Max retries reached. Exiting..."
          fi
        '';
      }
    }/bin/hyperhdr-wrapper
    X-GNOME-Autostart-enabled=true
    OnlyShowIn=GNOME;
  '';

  # Writable config directory
  home-manager.users."user".xdg.configFile."_hyperhdr" = {

    # Copy config into place to prevent read-only errors
    onChange =
      let
        dir = config.home-manager.users."user".xdg.configHome;
      in
      ''
        rm -rf ${dir}/hyperhdr
        cp -rL ${dir}/_hyperhdr ${dir}/hyperhdr
        chmod -R u+w ${dir}/hyperhdr
      '';

    source = ../resources/hyperhdr;
  };

  # Prevent fullscreen pipewire issues
  environment.systemPackages = with pkgs; [ gnomeExtensions.disable-unredirect-fullscreen-windows ];

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Prevent screen lock
    settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [
        gnomeExtensions.disable-unredirect-fullscreen-windows.extensionUuid
      ];
    };
  };

  users.users."user".extraGroups = [ "dialout" ];
}
