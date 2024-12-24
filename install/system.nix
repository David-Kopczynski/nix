{ config, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
