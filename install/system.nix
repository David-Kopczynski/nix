{ config, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Prevent shutdown delays
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  systemd.user.extraConfig = config.systemd.extraConfig;
}
