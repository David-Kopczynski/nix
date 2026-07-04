{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Encryption
  boot.initrd.luks.devices."crypted" = {

    device = "/dev/disk/by-partlabel/disk-system-crypted";
  };

  # System
  fileSystems."/" = lib.mkForce {
    device = "/dev/mapper/vg-root";
    fsType = "ext4";
  };
  fileSystems."/boot" = lib.mkForce {
    device = "/dev/disk/by-partlabel/disk-system-ESP";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };
  swapDevices = lib.mkForce [ { device = "/dev/mapper/vg-swap"; } ];

  # Keyboard layout
  console.keyMap = "de";

  # User
  users.users."user" = {

    extraGroups = [ "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
  };
}
