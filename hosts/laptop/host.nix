{ config, pkgs, ... }:

{
    # Hardware supported
    hardware.bluetooth.enable = true;

    # Graphic card drivers
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Finger scanner
    services.fprintd.enable = true; # Store fingerprints with `fprintd-enroll`
}
