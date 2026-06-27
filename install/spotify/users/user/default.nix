{ user }:

{
  home-manager.users.${user} = { pkgs, ... }: {

    home.packages = with pkgs; [ spotify ];

    # Show application in quick launcher
    dconf.settings."org/gnome/shell".favorite-apps = [ "spotify.desktop" ];
  };
}
