{ config, pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    platformio-core
    openocd
  ];

  users.users.${config.user}.extraGroups = [ "dialout" ];
}
