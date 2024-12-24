{ config, ... }:

{
  # Fetch hardware config from nixos-hardware
  imports = [
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/gpu/nvidia/turing>
    <nixos-hardware/common/cpu/intel/cpu-only.nix>
  ];

  # Hardware supported
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.graphics.enable = true;

  # Additional drives
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/941fa4a1-3f46-4db9-8a2f-50f1ee2ac3f5";
    fsType = "ext4";
    options = [
      "defaults"
      "x-gvfs-show"
    ];
  };

  home-manager.users.${config.user}.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable FreeSync support
    settings."org/gnome/mutter" = {
      experimental-features = [ "variable-refresh-rate" ];
    };

    # Disable sleep mode
    settings."org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
  };

  # Enable firmware updates
  services.fwupd.enable = true;

  system.stateVersion = "23.11";
}
