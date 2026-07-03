{ ... }:

{
  disko.devices.disk =
    # Default disk setup using EFI partition with LUKS
    {
      "system" = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            "ESP" = {
              priority = 1;
              size = "510M"; # Align with 1MiB padding at start and end of disk
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            "crypted" = {
              priority = 2;
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                enrollFido2 = true;
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "vg";
                };
              };
            };
          };
        };
      };
    };

  disko.devices.lvm_vg =
    # Simple LVM setup on top of LUKS
    {
      "vg" = {
        type = "lvm_vg";
        lvs = {
          "root" = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" ];
            };
          };
          "swap" = {
            size = "32G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
        };
      };
    };
}
