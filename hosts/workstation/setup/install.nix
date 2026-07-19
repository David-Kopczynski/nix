{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Encryption
  boot.initrd.luks.devices."crypted" = {

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
