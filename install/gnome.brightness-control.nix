{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnomeExtensions.brightness-control-using-ddcutil ] ++ [ ddcutil ];

  # Allow access to I2C peripherals
  hardware.i2c.enable = true;
  users.users.user.extraGroups = [ "i2c" ];

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [ brightness-control-using-ddcutil.extensionUuid ];
    };
  };
}