{ config, pkgs, ... }:

{
  # Fetch hardware config from nixos-hardware
  imports = [
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/13-inch/13th-gen-intel"
  ];

  # Wayland support
  services.xserver.displayManager.gdm.wayland = true;
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland"; # keepassxc / QT apps will use xwayland by default - override
    NIXOS_OZONE_WL = "1"; # Ensure Electron / "Ozone platform" apps enable using wayland in NixOS
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
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
