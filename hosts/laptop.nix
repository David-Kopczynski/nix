{ config, ... }:

{
  system.name = "laptop";
  nixpkgs.hostPlatform = "x86_64-linux";

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
    yubikey.gracePeriod = 60;
    yubikey.storage.device = config.fileSystems."/boot".device;
    yubikey.twoFactor = false;
  };

  # File systems
  swapDevices = [ { device = "/dev/mapper/vg-swap"; } ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-system-ESP";
    fsType = "vfat";
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
  powerManagement.cpuFreqGovernor = "ondemand";
  powerManagement.powertop.enable = true;
  networking.networkmanager.wifi.powersave = true;

  services.thermald.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "24.11";
  home-manager.users."user".home.stateVersion = "24.11";
}
