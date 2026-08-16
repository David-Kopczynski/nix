{ user }:

{
  home-manager.users.${user} = { lib, ... }: {

    # Show application in quick launcher
    dconf.settings."org/gnome/shell".favorite-apps = [ "org.gnome.Nautilus.desktop" ];

    # Shortcut
    dconf.settings."org/gnome/settings-daemon/plugins/media-keys".home = lib.toList "<Super>e";
  };
}
