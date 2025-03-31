{ config, lib, ... }:

{
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Main applications
    settings."org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "firefox-esr.desktop"
        "spotify.desktop"
        "org.gnome.Console.desktop"
      ];

      app-picker-layout =
        map
          (lib.lists.imap0 (
            i: name:
            (
              with lib.gvariant;
              mkDictionaryEntry name (mkVariant [ (mkDictionaryEntry "position" (mkVariant (mkUint32 i))) ])
            )
          ))
          [
            [
              # Page 1: General tools and utilities
              "nixos-manual.desktop"
              "org.gnome.Settings.desktop"
              "remote-viewer.desktop"
              "gnome"
              "com.github.wwmm.easyeffects.desktop"
              "btop.desktop"
              "nvim.desktop"
              "chromium-browser.desktop"
              "postman.desktop"
              "it.mijorus.smile.desktop"
            ]
            [
              # Page 2: Creative tools
              "gimp.desktop"
              "org.kde.krita.desktop"
              "org.darktable.darktable.desktop"
              "org.inkscape.Inkscape.desktop"
              "kicad"
              "blender.desktop"
              "f3d.desktop"
              "PrusaSlicer.desktop"
              "PrusaGcodeviewer.desktop"
              "mpv.desktop"
              "org.kde.kdenlive.desktop"
            ]
            [
              # Page 3: Office
              "thunderbird.desktop"
              "notion.desktop"
              "cups.desktop"
              "libre"
            ]
            [
              # Page 4: Games
              "nvidia-settings.desktop"
              "wootility.desktop"
              "webcord.desktop"
              "steam.desktop"
              "com.heroicgameslauncher.hgl.desktop"
              "net.lutris.Lutris.desktop"
              "org.prismlauncher.PrismLauncher.desktop"
              "r2modman.desktop"
              "dev.suyu_emu.suyu.desktop"
            ]
          ];
    };

    # Custom folders
    settings."org/gnome/desktop/app-folders" = {
      folder-children = [
        "gnome"
        "kicad"
        "libre"
      ];
    };

    settings."org/gnome/desktop/app-folders/folders/gnome" = {
      name = "GNOME";
      apps = [
        "org.gnome.Calendar.desktop"
        "org.gnome.Weather.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.Snapshot.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Extensions.desktop"
        "org.gnome.seahorse.Application.desktop"
      ];
    };
    settings."org/gnome/desktop/app-folders/folders/kicad" = {
      name = "KiCad";
      apps = [
        "org.kicad.kicad.desktop"
        "org.kicad.gerbview.desktop"
        "org.kicad.bitmap2component.desktop"
        "org.kicad.pcbcalculator.desktop"
        "org.kicad.pcbnew.desktop"
        "org.kicad.eeschema.desktop"
      ];
    };
    settings."org/gnome/desktop/app-folders/folders/libre" = {
      name = "LibreOffice";
      apps = [
        "startcenter.desktop"
        "base.desktop"
        "calc.desktop"
        "draw.desktop"
        "impress.desktop"
        "math.desktop"
        "writer.desktop"
      ];
    };

    # Modify top bar format
    settings."org/gnome/desktop/interface" = {
      accent-color = "green";
      clock-show-seconds = false;
      clock-show-weekday = false;
      enable-animations = true;
      show-battery-percentage = true;
    };

    # Add world clocks
    settings."org/gnome/clocks" = {
      world-clocks = with lib.gvariant; [
        [
          (mkDictionaryEntry "location" (
            mkVariant (mkTuple [
              (mkUint32 2)
              (mkVariant (mkTuple [
                "Coordinated Universal Time (UTC)"
                "@UTC"
                false
                (mkEmptyArray (type.tupleOf ([ type.double ] ++ [ type.double ])))
                (mkEmptyArray (type.tupleOf ([ type.double ] ++ [ type.double ])))
              ]))
            ])
          ))
        ]
        [
          (mkDictionaryEntry "location" (
            mkVariant (mkTuple [
              (mkUint32 2)
              (mkVariant (mkTuple [
                "Berlin"
                "EDDT"
                true
                [ (mkTuple ([ 0.9174614159494501 ] ++ [ 0.23241968454167572 ])) ]
                [ (mkTuple ([ 0.916588751323453 ] ++ [ 0.23387411976724018 ])) ]
              ]))
            ])
          ))
        ]
      ];
    };
    settings."org/gnome/shell/world-clocks" = {
      locations = with lib.gvariant; [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Coordinated Universal Time (UTC)"
            "@UTC"
            false
            (mkEmptyArray (type.tupleOf ([ type.double ] ++ [ type.double ])))
            (mkEmptyArray (type.tupleOf ([ type.double ] ++ [ type.double ])))
          ]))
        ]))
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Berlin"
            "EDDT"
            true
            [ (mkTuple ([ 0.9174614159494501 ] ++ [ 0.23241968454167572 ])) ]
            [ (mkTuple ([ 0.916588751323453 ] ++ [ 0.23387411976724018 ])) ]
          ]))
        ]))
      ];
    };

    # Add weather
    settings."org/gnome/Weather" = {
      locations = with lib.gvariant; [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Aachen"
            "ETNG"
            false
            [ (mkTuple ([ 0.8895361479175408 ] ++ [ 0.10559241974565695 ])) ]
            [ (mkTuple ([ 0.8895361479175408 ] ++ [ 0.10559241974565695 ])) ]
          ]))
        ]))
      ];
    };
    settings."org/gnome/shell/weather" = {
      automatic-location = true;
      locations = with lib.gvariant; [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Aachen"
            "ETNG"
            false
            [ (mkTuple ([ 0.8895361479175408 ] ++ [ 0.10559241974565695 ])) ]
            [ (mkTuple ([ 0.8895361479175408 ] ++ [ 0.10559241974565695 ])) ]
          ]))
        ]))
      ];
    };

    # Datetime
    settings."org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    # Formats and units
    settings."system/locale" = {
      region = "de_DE.UTF-8";
    };
  };

  # System locale and formats
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
}
