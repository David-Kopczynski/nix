{ config, pkgs, ... }:

{
    # Enable windowing system
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    services.xserver.libinput.touchpad.naturalScrolling = true;
}
