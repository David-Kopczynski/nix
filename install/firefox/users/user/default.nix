{ user }:

{
  home-manager.users.${user} = { ... }: {

    # Show application in quick launcher
    dconf.settings."org/gnome/shell".favorite-apps = [ "firefox.desktop" ];
  };
}
