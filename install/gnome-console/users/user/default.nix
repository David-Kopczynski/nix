{ user }:

{
  # Show application in quick launcher
  home-manager.users.${user} = { ... }: {
    dconf.settings."org/gnome/shell".favorite-apps = [ "org.gnome.Console.desktop" ];
  };
}
