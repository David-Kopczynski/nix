{ user }:

{
  home-manager.users.${user} = { lib, ... }: {

    dconf.settings."org/gnome/settings-daemon/plugins/media-keys" = {

      # Audio keybindings
      mic-mute = lib.toList "<Control>dead_acute";
    };
  };
}
