{ config, pkgs, ... }:

{
  # Fetch hardware config from nixos-hardware
  imports = [
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/13-inch/13th-gen-intel"
  ];

  # Wayland support
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland"; # keepassxc / QT apps will use xwayland by default - override
    NIXOS_OZONE_WL = "1"; # Ensure Electron / "Ozone platform" apps enable using wayland in NixOS
  };

  # Disable fingerprint for login
  # This prevents a race condition with some gnome related services
  # This also prevents the keyring from asking the password anyways
  security.pam.services.login.fprintAuth = false;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.i2c.enable = true;
  hardware.wooting.enable = true;

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
