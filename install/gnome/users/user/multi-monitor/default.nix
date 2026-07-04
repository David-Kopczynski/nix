{ user }:

{
  home-manager.users.${user} = { ... }: {

    dconf.settings."org/gnome/mutter" = {

      # Multitasking
      workspaces-only-on-primary = false;
    };
  };
}
