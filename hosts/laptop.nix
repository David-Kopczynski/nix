{ config, pkgs, ... }:

{
    # Fetch hardware config from nixos-hardware
    imports = [
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/13-inch/13th-gen-intel"
    ];

    # Enable bluetooth
    hardware.bluetooth.enable = true;
    hardware.wooting.enable = true;

    # Graphic card drivers
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Disable fingerprint login to prevent 30sec timeout when not using fingerprint after password login
    security.pam.services.login.fprintAuth = false;

    # Enable firmware updates
    services.fwupd.enable = true;
}
