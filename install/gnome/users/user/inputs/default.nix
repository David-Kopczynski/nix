{ user }:

{
  home-manager.users.${user} = { ... }: {

    dconf.settings."org/gnome/desktop/peripherals/mouse" = {

      # Mouse
      accel-profile = "flat";
    };
  };
}
