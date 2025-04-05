{ config, lib, ... }:

{
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Application layout
    settings."org/gnome/shell" = {
      favorite-apps = [ "org.gnome.Nautilus.desktop" ];
      app-picker-layout = [ ]; # alphabetically sort apps
    };

    # Collect applications by category
    settings."org/gnome/desktop/app-folders" = {
      folder-children = [
        "AudioVideo"
        "Browsing"
        "Design"
        "Development"
        "Games"
        "GNOME"
        "Office"
        "Utility"
        "System"
      ];
    };

    settings."org/gnome/desktop/app-folders/folders/AudioVideo" = {
      name = "Audio & Video";
      categories = [ "AudioVideo" ] ++ [ "Audio" ] ++ [ "Video" ] ++ [ "Recorder" ];
    };
    settings."org/gnome/desktop/app-folders/folders/Browsing" = {
      name = "Browsing";
      categories = [ "Network" ];
    };
    settings."org/gnome/desktop/app-folders/folders/Design" = {
      name = "Design";
      categories = [ "Graphics" ];
    };
    settings."org/gnome/desktop/app-folders/folders/Development" = {
      name = "Development";
      categories = [ "Development" ] ++ [ "Engineering" ];
    };
    settings."org/gnome/desktop/app-folders/folders/Games" = {
      name = "Games";
      categories = [ "Game" ];
    };
    settings."org/gnome/desktop/app-folders/folders/GNOME" = {
      name = "GNOME";
      categories = [ "GNOME" ];
    };
    settings."org/gnome/desktop/app-folders/folders/Office" = {
      name = "Office";
      categories = [ "Office" ] ++ [ "Chat" ];
    };
    settings."org/gnome/desktop/app-folders/folders/Utility" = {
      name = "Utility";
      categories = [ "Utility" ] ++ [ "ConsoleOnly" ];
    };
    settings."org/gnome/desktop/app-folders/folders/System" = {
      name = "System";
      categories = [ "System" ] ++ [ "Settings" ] ++ [ "Monitor" ];
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
