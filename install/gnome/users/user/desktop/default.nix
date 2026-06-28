{ user }:

{
  home-manager.users.${user} = { lib, ... }: {

    dconf.settings."org/gnome/desktop/wm/keybindings" = {

      # Desktop keybindings
      switch-applications = with lib.gvariant; mkEmptyArray type.string;
      switch-applications-backward = with lib.gvariant; mkEmptyArray type.string;
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };
  };
}
