{ config, ... }:

{
  system.name = "workstation";
  nixpkgs.hostPlatform = "x86_64-linux";

  # Fetch hardware config from nixos-hardware
  imports = [
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/gpu/nvidia/turing>
    <nixos-hardware/common/cpu/intel/cpu-only.nix>
  ];

  boot.kernelParams = [ "intel_iommu=on" ] ++ [ "mem_sleep_default=s2idle" ];
  boot.kernelModules = [ "kvm-intel" ];

  # File systems
  swapDevices = [
    {
      device = "/dev/disk/by-partlabel/swap";
      randomEncryption.enable = true;
      randomEncryption.allowDiscards = config.services.fstrim.enable;
    }
  ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "defaults" ] ++ [ "x-gvfs-show" ];
  };

  services.smartd.enable = true;

  # Hardware supported
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.graphics.enable = true;
  hardware.nvidia.powerManagement.enable = true;

  home-manager.users."user" = {

    dconf = {
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

    # Monitor configuration
    xdg.configFile."_monitors.xml" = {

      # Copy config into place to prevent read-only errors
      onChange =
        let
          dir = config.home-manager.users."user".xdg.configHome;
        in
        ''
          rm -f ${dir}/monitors.xml
          cp ${dir}/_monitors.xml ${dir}/monitors.xml
          chmod u+w ${dir}/monitors.xml
        '';

      source = ../resources/gnome/workstation-monitors.xml;
    };
  };

  # Performance tweaks
  services.preload.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "23.11";
  home-manager.users."user".home.stateVersion = "24.05";
}
