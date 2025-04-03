{ config, ... }:

{
  system.name = "laptop";
  nixpkgs.hostPlatform = "x86_64-linux";

  # Fetch hardware config from nixos-hardware
  imports = [ <nixos-hardware/framework/13-inch/13th-gen-intel> ];

  # Boot parameters taken from hardware-configuration.nix
  boot.initrd.availableKernelModules =
    [
      "nvme"
    ]
    ++
    # Optimization for LUKS unlock
    [
      "aesni_intel"
      "cryptd"
    ];
  boot.kernelModules =
    [ "kvm-intel" ]
    ++
    # YubiKey support during boot
    [
      "vfat"
      "nls_cp437"
      "nls_iso8859-1"
      "usbhid"
    ];

  # Encryption with LUKS any YubiKey
  boot.initrd.luks.yubikeySupport = true;
  boot.initrd.luks.devices."crypted" = {

    allowDiscards = config.services.fstrim.enable;
    device = "/dev/disk/by-partlabel/disk-system-crypted";
    yubikey.twoFactor = false;
  };

  # File systems
  swapDevices = [ { device = "/dev/mapper/vg-swap"; } ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-system-ESP";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  fileSystems."/" = {
    device = "/dev/mapper/vg-root";
    fsType = "ext4";
  };

  services.smartd.enable = true;

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

      # Disable caps lock
      settings.main.capslock = "overload(caps, esc)";
      settings.caps = {

        # Special layer characters
        w = "pageup";
        a = "home";
        s = "pagedown";
        d = "end";

        "1" = "f1";
        "2" = "f2";
        "3" = "f3";
        "4" = "f4";
        "5" = "f5";
        "6" = "f6";
        "7" = "f7";
        "8" = "f8";
        "9" = "f9";
        "0" = "f10";
        minus = "f11";
        equal = "f12";
      };
    };
  };

  # Better battery life
  powerManagement.powertop.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "23.11";
  home-manager.users."user".home.stateVersion = "24.05";
}
