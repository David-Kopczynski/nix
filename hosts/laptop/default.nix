{ config, lib, ... }:

{
  system.name = "laptop";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports =
    # Source nixos-hardware configuration
    [
      <nixos-hardware/framework/13-inch/13th-gen-intel>
    ]
    # Source extra configuration from ./extra/*
    ++ lib.pipe (builtins.readDir ./extra) [
      (x: map (n: lib.filesystem.resolveDefaultNix ./extra/${n}) (builtins.attrNames x))
    ];

  # Additional hardware tweaks
  hardware.intelgpu.loadInInitrd = lib.mkForce true;
  hardware.enableRedistributableFirmware = true;

  # Boot parameters
  boot.kernelParams = [ "mem_sleep_default=s2idle" ];
  boot.resumeDevice = lib.mkDefault (lib.head config.swapDevices).device;

  boot.initrd.availableKernelModules = [ "thunderbolt" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

  # Encryption with Yubikey
  boot.initrd.luks.devices."crypted" = {

    allowDiscards = config.services.fstrim.enable;
    bypassWorkqueues = config.services.fstrim.enable;
    crypttabExtraOpts = [ "fido2-device=auto" ];
    device = "/dev/disk/by-partlabel/disk-system-crypted";
  };

  # System
  fileSystems = {

    "/" = {
      device = "/dev/mapper/vg-root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/disk-system-ESP";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };
  };

  swapDevices = lib.toList {
    device = "/dev/mapper/vg-swap";
    discardPolicy = lib.optionalString config.services.fstrim.enable "both";
  };

  # Versions
  system.stateVersion = "24.11";
  home-manager.users."user".home.stateVersion = "24.11";
}
