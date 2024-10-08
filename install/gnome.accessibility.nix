{ config, lib, ... }:

with lib.gvariant;
{
  home-manager.users.user.dconf = {
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
      switch-applications = mkEmptyArray type.string;
      switch-applications-backward = mkEmptyArray type.string;
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-terminal/" ];

      home = [ "<Super>e" ];
      mic-mute = [ "<Control>dead_acute" ];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-terminal" = {
      name = "terminal";
      command = "kgx";
      binding = "<Control><Alt>t";
    };
  };
}
