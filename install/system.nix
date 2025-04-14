{ config, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 16;
  boot.loader.efi.canTouchEfiVariables = true;

  # Splash screen
  boot.plymouth.enable = true;
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  # Automatically keep system clean
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 14d";

  # Prevent shutdown delays
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  systemd.user.extraConfig = config.systemd.extraConfig;
}
