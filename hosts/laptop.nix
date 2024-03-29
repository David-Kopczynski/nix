{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "laptop") {

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
    security.pam.services.login.fprintAuth = false; # Disable fingerprint login to prevent 30sec timeout when not using fingerprint after password login
}
