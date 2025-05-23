{ config, lib, ... }:

{
  system.name = "workstation";
  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.11";
  home-manager.users."user".home.stateVersion = "24.05";

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
  hardware.graphics.enable = true;
  hardware.nvidia.powerManagement.enable = true;

  home-manager.users."user" = {

    dconf = {
      inherit (config.programs.dconf) enable;

      # Enable FreeSync support and configure HDR
      settings."org/gnome/mutter" = {

        experimental-features = [ "variable-refresh-rate" ];
        output-luminance = with lib.gvariant; [
          (mkTuple [
            "DP-2"
            "GBT"
            "Gigabyte M32Q"
            "0x0000038a"
            (mkUint32 1)
            75.0
          ])
        ];
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

  # Disable unused audio outputs
  services.pipewire.wireplumber.enable = true;
  services.pipewire.wireplumber.extraConfig = {

    "disable-unused-audio"."monitor.alsa.rules" = [
      {
        actions.update-props."device.disabled" = true;
        matches = [
          { "device.nick" = "Logi 4K Stream Edition"; } # Webcam
          { "device.nick" = "HDA Intel PCH"; } # OnBoard Sound
        ];
      }
    ];
  };

  # Performance tweaks
  services.preload.enable = true;

  services.thermald.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
}
