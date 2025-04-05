{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ spotify ];

  # Main application
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/shell" = {
      favorite-apps = [ "spotify.desktop" ];
    };
  };
}
