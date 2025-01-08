{ config, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 16;
  boot.loader.efi.canTouchEfiVariables = true;

  # Automatically keep system clean
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 14d";

  # Path to nixos-configuration
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=${config.root}"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Prevent shutdown delays
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  systemd.user.extraConfig = config.systemd.extraConfig;
}
