{ config, ... }:

{
  system.name = "laptop";
  nixpkgs.hostPlatform = "x86_64-linux";

  # Fetch hardware config from nixos-hardware
  imports = [ <nixos-hardware/framework/13-inch/13th-gen-intel> ];

  # Boot parameters taken from hardware-configuration.nix
  boot.initrd.availableKernelModules = [ "nvme" ];
  boot.kernelModules = [ "kvm-intel" ];

  # File systems
  swapDevices = [ ];
  zramSwap.enable = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
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

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable fractional scaling
    settings."org/gnome/mutter" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    };
  };

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

  system.stateVersion = "23.11";
  home-manager.users."user".home.stateVersion = "24.05";
}
