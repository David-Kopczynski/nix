{ config, pkgs, ... }:

{
    # Enable windowing system
    services.xserver.enable = true;

    # Enable gnome desktop
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = false; # This is an patch for NVIDIA as wayland crashes
    services.xserver.desktopManager.gnome.enable = true;

    # Remove unnecessary packages from gnome
    environment.gnome.excludePackages = (with pkgs; [
        gnome-tour
        gnome-connections
        gnome.gnome-music
        gnome.gnome-terminal
        gnome.gedit
        gnome.epiphany
        gnome.geary
        gnome.tali
        gnome.iagno
        gnome.hitori
        gnome.atomix
        gnome.simple-scan
        gnome.yelp
        gnome.gnome-contacts
        gnome.gnome-maps
        gnome.gnome-weather
        gnome.gnome-calendar
    ]);
}
