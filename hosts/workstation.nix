{ config, pkgs, ... }:

{
    # Fetch hardware config from nixos-hardware
    imports = [
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/pc"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/pc/ssd"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/gpu/nvidia"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/cpu/intel/cpu-only.nix"
    ];

    services.xserver.displayManager.gdm.wayland = false; # This is an patch for NVIDIA as wayland crashes

    # Hardware supported
    hardware.bluetooth.enable = true;
    hardware.wooting.enable = true;
    hardware.i2c.enable = true;

    # Graphic card drivers
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # GPU drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Additional drives
    fileSystems."/mnt/data" = {
        device = "/dev/disk/by-uuid/941fa4a1-3f46-4db9-8a2f-50f1ee2ac3f5";
        fsType = "ext4";
        options = ["defaults" "x-gvfs-show"];
    };

    # Enable firmware updates
    services.fwupd.enable = true;
}
