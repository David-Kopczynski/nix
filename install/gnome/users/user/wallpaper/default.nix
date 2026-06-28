{ user }:

{
  home-manager.users.${user} = { osConfig, ... }: {

    dconf.settings."org/gnome/desktop/background" = {

      # Theming
      picture-uri = "file://${osConfig.sops.secrets."user/wallpaper/picture".path}";
      picture-uri-dark = "file://${osConfig.sops.secrets."user/wallpaper/picture-dark".path}";
      picture-options = "spanned";
      color-shading-type = "solid";
      primary-color = "#000000";
    };
  };

  # Unfree wallpaper
  sops.secrets."user/wallpaper/picture" = {

    sopsFile = ./picture;
    format = "binary";
    owner = user;
  };
  sops.secrets."user/wallpaper/picture-dark" = {

    sopsFile = ./picture-dark;
    format = "binary";
    owner = user;
  };
}
