{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Disable sound error beep
    settings."org/gnome/desktop/sound" = {
      event-sounds = false;
    };

    # Mouse
    settings."org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    # Window manager
    settings."org/gnome/mutter" = {
      edge-tiling = true;
    };

    # Touchpad
    settings."org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    # Keyboard keybindings
    settings."org/gnome/desktop/wm/keybindings" = {
      switch-applications = with lib.gvariant; mkEmptyArray type.string;
      switch-applications-backward = with lib.gvariant; mkEmptyArray type.string;
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-terminal/"
      ];

      home = [ "<Super>e" ];
      mic-mute = [ "<Control>dead_acute" ];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-terminal" = {
      name = "terminal";
      command = "kgx";
      binding = "<Control><Alt>t";
    };

    # Display color
    settings."org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = true;
      night-light-temperature = lib.gvariant.mkUint32 4700;
    };

    # File history and trash
    settings."org/gnome/desktop/privacy" = {
      remember-recent-files = true;
      recent-files-max-age = lib.gvariant.mkUint32 7;

      remove-old-trash-files = true;
      remove-old-temp-files = true;
      remove-trash-days = lib.gvariant.mkUint32 30;
    };
  };

  # Inherit specific settings for GDM
  programs.dconf.profiles.gdm.databases = [
    {
      lockAll = true;

      settings =
        pkgs.lib.pipe
          [
            "org/gnome/desktop/peripherals/mouse"
            "org/gnome/desktop/peripherals/touchpad"
            "org/gnome/settings-daemon/plugins/color"
          ]
          [
            (builtins.map (n: {
              name = "${n}";
              value = config.home-manager.users."user".dconf.settings."${n}";
            }))
            builtins.listToAttrs
          ];
    }
  ];

  # Keyboard layout
  console.keyMap = "de";
  services.xserver.xkb.layout = "de";
}
