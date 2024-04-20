{ config, pkgs, ... }:

{
    # Fetch hardware config from nixos-hardware
    imports = [
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/13-inch/13th-gen-intel"
    ];

    # Enable bluetooth
    hardware.bluetooth.enable = true;
    hardware.wooting.enable = true;
    hardware.i2c.enable = true;

    # Graphic card drivers
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Enable firmware updates
    services.fwupd.enable = true;
}
