{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ]
    ++ [ gnomeExtensions.brightness-control-using-ddcutil ddcutil ]
    ++ [ gnomeExtensions.color-picker ]
    ++ [ gnomeExtensions.executor ]
    ++ [ gnomeExtensions.just-perfection ]
    ++ [ gnomeExtensions.smile-complementary-extension smile ]
    ++ [ gnomeExtensions.user-themes-x ]
    ++ [ gnomeExtensions.x11-gestures ]
    ++ [ libsForQt5.kdenlive ];

  # Remove unnecessary/default gnome applications
  environment.gnome.excludePackages = with pkgs.gnome; [ pkgs.gnome-tour yelp gnome-characters ];

  hardware.i2c.enable = true;
  users.users.user = {

    # I2C access for ddcutil
    extraGroups = [ "i2c" ];
  };

  # Enable multi-touch gestures
  services.touchegg.enable = true;

  # Enable KDE Connect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Force QT applications to use dark theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
