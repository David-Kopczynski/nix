{ user }:

{
  home-manager.users.${user} = { lib, ... }: {

    dconf.settings."org/gnome/desktop/wm/keybindings" = {

      # Desktop keybindings
      switch-applications = with lib.gvariant; mkEmptyArray type.string;
      switch-applications-backward = with lib.gvariant; mkEmptyArray type.string;
      switch-windows = lib.toList "<Alt>Tab";
      switch-windows-backward = lib.toList "<Shift><Alt>Tab";
    };
  };
}
