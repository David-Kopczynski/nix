{ pkgs, ... }:

{
  services = {

    # PlatformIO support
    # https://nixos.wiki/wiki/Platformio
    udev.packages = with pkgs; [ platformio-core openocd ];
  };

  users.users.user.extraGroups = [ "dialout" ];
}
