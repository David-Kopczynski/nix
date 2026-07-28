{ user }:

{
  home-manager.users.${user} = { ... }: {

    gtk.enable = true;
    gtk = {

      # General
      colorScheme = "dark";
      gtk4.theme = null;
    };
  };
}
