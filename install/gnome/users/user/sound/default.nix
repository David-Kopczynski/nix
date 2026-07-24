{ user }:

{
  home-manager.users.${user} = { ... }: {

    dconf.settings."org/gnome/desktop/sound/event-sounds" = {

      # Disable sounds
      event-sounds = false;
    };
  };
}
