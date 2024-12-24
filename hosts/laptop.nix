{ ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";

  # Fetch hardware config from nixos-hardware
  imports = [ <nixos-hardware/framework/13-inch/13th-gen-intel> ];

  # Boot parameters taken from hardware-configuration.nix
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

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

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.graphics.enable = true;

  # Remap keyboard keys
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      # Open terminal with FK12
      settings.main.media = "C-A-t";
    };
  };

  # Better battery life
  powerManagement.powertop.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
