{ config, ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";

  # Fetch hardware config from nixos-hardware
  imports = [
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/gpu/nvidia/turing>
    <nixos-hardware/common/cpu/intel/cpu-only.nix>
  ];

  # Boot parameters taken from hardware-configuration.nix
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [
    "kvm-intel"
  ];

  # File systems
  swapDevices = [ ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [
      "defaults"
      "x-gvfs-show"
    ];
  };

  # Hardware supported
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.graphics.enable = true;

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable FreeSync support
    settings."org/gnome/mutter" = {
      experimental-features = [ "variable-refresh-rate" ];
    };

    # Disable sleep mode
    settings."org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
  };

  # Enable firmware updates
  services.fwupd.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "23.11";
  home-manager.users."user".home.stateVersion = "24.05";
}
