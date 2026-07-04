{ config, lib, ... }:

{
  system.name = "workstation";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports =
    # Source nixos-hardware configuration
    [
      <nixos-hardware/common/pc>
      <nixos-hardware/common/pc/ssd>
      <nixos-hardware/common/gpu/nvidia/turing>
      <nixos-hardware/common/cpu/intel/cpu-only.nix>
    ]
    # Source extra configuration from ./extra/*
    ++ lib.pipe (builtins.readDir ./extra) [
      (x: map (n: lib.filesystem.resolveDefaultNix ./extra/${n}) (builtins.attrNames x))
    ];

  # Additional hardware tweaks
  hardware.enableRedistributableFirmware = true;
  hardware.nvidia.branch = "latest";
  hardware.nvidia.nvidiaSettings = false;
  hardware.nvidia.powerManagement.enable = true;

  # Boot parameters
  boot.kernelParams = [
    "intel_iommu=on"
    "video=DP-1:1920x1080@75,panel_orientation=left"
    "video=DP-2:2560x1440@165"
    "video=DP-3:2560x1080@75"
  ];
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.blacklistedKernelModules = [ "i2c_nvidia_gpu" ];
  boot.resumeDevice = lib.mkDefault (lib.head config.swapDevices).device;

  boot.kernelModules = [ "kvm-intel" ];

  # System
  fileSystems = {

    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };
    "/mnt/data" = {
      device = "/dev/disk/by-label/data";
      fsType = "ext4";
      options = [ "defaults" ] ++ [ "x-gvfs-show" ];
    };
  };

  swapDevices = lib.toList {
    device = "/dev/disk/by-partlabel/swap";
    discardPolicy = lib.optionalString config.services.fstrim.enable "both";
  };

  # Versions
  system.stateVersion = "23.11";
  home-manager.users."user".home.stateVersion = "24.05";
}
