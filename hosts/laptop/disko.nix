{
  pkgs ? import <nixpkgs> { },
  ...
}:

{
  disko.devices.disk =
    # Default disk setup using EFI partition with LUKS
    {
      "system" = {
        device = "/dev/nvme0n1";
        type = "disk";
        preCreateHook = ''
          mkdir -p /tmp/disko

          ITERATIONS=1000000

          rbtohex() { ( od -An -vtx1 | tr -d ' \n' ) }
          hextorb() { ( tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI'| xargs printf ) }

          SALT="$(dd if=/dev/random bs=1 count=16 2>/dev/null | rbtohex)"
          CHALLENGE="$(echo -n "$SALT" | ${with pkgs; openssl}/bin/openssl dgst -binary -sha512 | rbtohex)"
          RESPONSE=$(${with pkgs; yubikey-personalization}/bin/ykchalresp -2 -x "$CHALLENGE" 2>/dev/null)
          LUKS_KEY="$(echo | ${
            pkgs.callPackage "${
              pkgs.fetchFromGitHub {
                owner = "sgillespie";
                repo = "nixos-yubikey-luks";
                rev = "master";
                sha256 = "sha256-qmvBrvSo30kW+meehETdgjvxCmrWrc5cBBGdViJ39gU=";
              }
            }/pbkdf2-sha512" { }
          }/bin/pbkdf2-sha512 $((512 / 8)) $ITERATIONS "$RESPONSE" | rbtohex)"

          echo -n "$LUKS_KEY" | hextorb > /tmp/disko/key-file
          echo -ne "$SALT\n$ITERATIONS" > /tmp/disko/crypt-storage
        '';
        postCreateHook = ''
          rm /tmp/disko/key-file
        '';
        postMountHook = ''
          mkdir -p /boot/crypt-storage
          cp /tmp/disko/crypt-storage /boot/crypt-storage/default
        '';
        content = {
          type = "gpt";
          partitions = {
            "ESP" = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            "crypted" = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [
                  "--cipher aes-xts-plain64"
                  "--key-size 512"
                  "--hash sha512"
                ];
                settings = {
                  allowDiscards = true;
                  keyFile = "/tmp/disko/key-file";
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
