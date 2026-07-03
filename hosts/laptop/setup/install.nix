{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Boot parameters
  boot.initrd.availableKernelModules = [ "thunderbolt" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

  # Encryption with Yubikey
  boot.initrd.luks.devices."crypted" = {

    crypttabExtraOpts = [ "fido2-device=auto" ];
    device = "/dev/disk/by-partlabel/disk-system-crypted";
  };

  # System
  fileSystems."/" = {
    device = "/dev/mapper/vg-root";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-system-ESP";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };
  swapDevices = [ { device = "/dev/mapper/vg-swap"; } ];

  # Keyboard layout
  console.keyMap = "de";

  # User
  users.users."user" = {

    extraGroups = [ "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
  };
}
