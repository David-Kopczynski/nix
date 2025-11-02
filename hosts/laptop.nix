{ config, lib, ... }:

{
  system.name = "laptop";
  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "24.11";
  home-manager.users."user".home.stateVersion = "24.11";

  # Fetch hardware config from nixos-hardware
  imports = [ <nixos-hardware/framework/13-inch/13th-gen-intel> ];

  boot.kernelParams = [ "mem_sleep_default=s2idle" ];

  # Encryption with LUKS any YubiKey
  boot.initrd.availableKernelModules = [ "aesni_intel" ] ++ [ "i915" ];
  boot.initrd.kernelModules = [ "vfat" ] ++ [ "nls_cp437" ] ++ [ "nls_iso8859-1" ] ++ [ "usbhid" ];

  boot.initrd.luks.yubikeySupport = true;
  boot.initrd.luks.devices."crypted" = {

    allowDiscards = config.services.fstrim.enable;
    bypassWorkqueues = config.services.fstrim.enable;
    device = "/dev/disk/by-partlabel/disk-system-crypted";
    yubikey.gracePeriod = 15;
    yubikey.storage.device = config.fileSystems."/boot".device;
    yubikey.twoFactor = false;
  };

  # File systems
  swapDevices = [
    {
      device = "/dev/mapper/vg-swap";
      options = [ "defaults" ] ++ lib.optionals config.services.fstrim.enable [ "discard" ];
    }
  ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-system-ESP";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/mapper/vg-root";
    fsType = "ext4";
  };

  services.smartd.enable = true;

  # Hardware supported
  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable fractional scaling
    settings."org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ] ++ [ "xwayland-native-scaling" ];
    };
  };

  sops.secrets."laptop/fprint.right-index" = {
    format = "binary";
    path = "/var/lib/fprint/user/goodixmoc/UID742C7B57_XXXX_MOC_B0/7";
    sopsFile = ../resources/sops/laptop/fprint.right-index;
  };

  # Better battery life
  powerManagement.cpuFreqGovernor = "ondemand";
  powerManagement.powertop.enable = true;
  networking.networkmanager.wifi.powersave = true;

  services.thermald.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
}
