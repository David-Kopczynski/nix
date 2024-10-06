{ config, ... }:

{
  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/background" = {
      picture-uri = "file://${config.root}/resources/gnome/wallpaper-bright.jpg";
      picture-uri-dark = "file://${config.root}/resources/gnome/wallpaper-dark.jpg";
    };
  };
}
