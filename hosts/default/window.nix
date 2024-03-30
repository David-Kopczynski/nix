{ config, pkgs, ... }:

{
    # Enable windowing system
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    # Mouse and touchpad settings
    services.xserver.libinput.mouse.accelProfile = "flat";
    services.xserver.libinput.touchpad.naturalScrolling = true;
}
