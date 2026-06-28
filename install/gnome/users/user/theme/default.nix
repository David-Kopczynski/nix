{ user }:

{
  home-manager.users.${user} = { ... }: {

    dconf.settings."org/gnome/desktop/interface" = {

      # Theming
      accent-color = "green";
    };
  };
}
