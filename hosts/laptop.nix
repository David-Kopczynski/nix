{ config, pkgs, ... }:

{
  # Fetch hardware config from nixos-hardware
  imports = [ <nixos-hardware/framework/13-inch/13th-gen-intel> ];

  # Disable fingerprint for login
  # This prevents a race condition with some gnome related services
  # This also prevents the keyring from asking the password anyways
  security.pam.services.login.fprintAuth = false;

  services.xserver.displayManager.gdm.wayland = false;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Better battery life
  powerManagement.powertop.enable = true;

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Enable firmware updates
  services.fwupd.enable = true;
}
