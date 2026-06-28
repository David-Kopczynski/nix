{ user }:

{
  home-manager.users.${user} = { ... }: {

    dconf.settings."org/gnome/desktop/privacy" = {

      # Automatically clean system
      remove-old-trash-files = true;
      remove-old-temp-files = true;
    };
  };
}
