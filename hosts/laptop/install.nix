{ config, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  fileSystems."/boot".device = "/dev/nvme0n1p1";
  fileSystems."/".device = "/dev/nvme0n1p2";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS
  boot.initrd.availableKernelModules = [ "aesni_intel" ] ++ [ "cryptd" ];
  boot.kernelModules = [ "vfat" ] ++ [ "nls_cp437" ] ++ [ "nls_iso8859-1" ] ++ [ "usbhid" ];

  boot.initrd.luks.yubikeySupport = true;
  boot.initrd.luks.devices."crypted" = {

    allowDiscards = config.services.fstrim.enable;
    device = config.fileSystems."/".device;
    yubikey.storage.device = config.fileSystems."/boot".device;
    yubikey.twoFactor = false;
  };

  # User
  users.users."user" = {

    extraGroups = [ "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
  };
}
