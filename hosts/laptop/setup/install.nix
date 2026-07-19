{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Encryption with Yubikey
  boot.initrd.luks.devices."crypted" = {

    crypttabExtraOpts = [ "fido2-device=auto" ];
    device = "/dev/disk/by-partlabel/disk-system-crypted";
  };

  # Keyboard layout
  console.keyMap = "de";

  # User
  users.users."user" = {

    extraGroups = [ "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
  };

  # SSH Keys
  services.openssh.generateHostKeys = true;
}
