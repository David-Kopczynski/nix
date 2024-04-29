{ config, pkgs, ... }:

{
  # Enable windowing system
  services.xserver.enable = true;

  # Enable gnome desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Force QT applications to use dark theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
