# ❄️ Laptop
My Framework 13 (13th gen) laptop is installed with a LUKS setup, running LVM with ext4. Unlocking the LUKS partition is done with a YubiKey!

## 🚀 Setup
First, make sure to have the secret configured on the YubiKey:

```bash
nix-shell luks_yubikey_generate.sh # if freshly setting up
nix-shell luks_yubikey_restore.sh  # if trying to restore secret
```

To install the partition layout and NixOS, simply run the following commands:

```bash
nix-shell -p disko --run "sudo disko --mode disko disko.nix"
sudo nixos-generate-config --root /mnt
```

Then, copy the base configuration to get things started with `sudo nano /mnt/etc/nixos/configuration.nix`:

```nix
{
  boot.kernelModules = [
    "vfat"
    "nls_cp437"
    "nls_iso8859-1"
    "usbhid"
  ];
  boot.initrd.luks.yubikeySupport = true;
  boot.initrd.luks.devices."crypted" = {
    allowDiscards = config.services.fstrim.enable;
    device = "/dev/disk/by-partlabel/disk-system-crypted";
    yubikey.twoFactor = false;
  };
}
```

Followed by the installation of the system:

```bash
sudo nixos-install
```

*It is important for this process to have the YubiKey inserted, as it is used to calculate the LUKS key.* \
*Also, backup the secret used for the YubiKey in a safe place in case of emergency!*
