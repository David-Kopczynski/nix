{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ vscode ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-text-editor ];

  services = {

    # PlatformIO support
    # https://nixos.wiki/wiki/Platformio
    udev.packages = with pkgs; [ platformio-core openocd ];
  };

  users.users.user = {

    # PlatformIO serial port access
    extraGroups = [ "dialout" ];
  };
}
