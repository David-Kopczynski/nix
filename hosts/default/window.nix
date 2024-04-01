{ config, pkgs, ... }:

{
    # Enable windowing system
    services.xserver.enable = true;

    # Enable gnome desktop
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = false; # This is an patch for NVIDIA as wayland crashes
    services.xserver.desktopManager.gnome.enable = true;

    # Remove unnecessary packages from gnome
    environment.gnome.excludePackages =
        (with pkgs; [
            gnome-tour                  # Tour of GNOME
        ])++ (with pkgs.gnome; [
            epiphany                    # web browser
            yelp                        # help browser
        ]);
}
