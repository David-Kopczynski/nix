{ config, pkgs, ... }:

{
    # Enable windowing system
    services.xserver.enable = true;

    # Enable gnome desktop
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Remove unnecessary packages from gnome
    environment.gnome.excludePackages = (with pkgs; [
        gnome-tour
        gnome.gnome-music
        gnome.gnome-terminal
        gnome.gedit
        gnome.epiphany
        gnome.geary
        gnome.tali
        gnome.iagno
        gnome.hitori
        gnome.atomix
    ]);
}
