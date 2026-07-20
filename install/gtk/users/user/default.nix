{ user }:

{
  home-manager.users.${user} = { config, pkgs, ... }: {

    gtk.enable = true;
    gtk = {

      # General
      colorScheme = "dark";
      theme.name = "adw-gtk3-dark";
      theme.package = with pkgs; adw-gtk3;
      gtk4.theme = config.gtk.theme;
    };
  };
}
