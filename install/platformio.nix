{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    platformio-core
    openocd
  ];

  users.users.user.extraGroups = [ "dialout" ];
}
