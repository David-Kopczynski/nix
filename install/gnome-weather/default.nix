{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnome-weather ];

  programs.dconf.profiles."user".databases = [
    {
      # Enable automatic weather for all users
      locks = [ "/org/gnome/shell/weather/automatic-location" ];
      settings."org/gnome/system/location".enabled = true;
      settings."org/gnome/shell/weather".automatic-location = true;
    }
  ];
}
