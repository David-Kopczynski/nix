{ config, pkgs, ... }:

{
  # Fetch hardware config from nixos-hardware
  imports = [
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/gpu/nvidia/turing>
    <nixos-hardware/common/cpu/intel/cpu-only.nix>
  ];

  # Hardware supported
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Latest GPU drivers
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
  hardware.nvidia.package = pkgs.unstable.linuxPackages.nvidiaPackages.stable;

  # Additional drives
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/941fa4a1-3f46-4db9-8a2f-50f1ee2ac3f5";
    fsType = "ext4";
    options = [ "defaults" "x-gvfs-show" ];
  };

  # Enable firmware updates
  services.fwupd.enable = true;
}
