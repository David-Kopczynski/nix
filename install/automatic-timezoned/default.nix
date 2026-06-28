{ ... }:

{
  services.automatic-timezoned.enable = true;

  programs.dconf.profiles."user".databases = [
    {
      # Enable automatic timezone for all users
      locks = [ "/org/gnome/desktop/datetime/automatic-timezone" ];
      settings."org/gnome/system/location".enabled = true;
      settings."org/gnome/desktop/datetime".automatic-timezone = true;
    }
  ];
}
