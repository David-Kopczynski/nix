# ❄️ Workstation
My **i7 13700kf** + **RTX 2070 Super** `workstation` is installed with a LUKS setup, running a LVM with ext4.

<details>
<summary>🔨 Installation</summary>

Start by going through the NixOS graphical installer, selecting the appropriate keyboard layout to allow us to proceed to the terminal. \
We wont be installing NixOS the classic way, but rather download this repository to get everything up and running:

```bash
git clone https://github.com/David-Kopczynski/nix.git
cd nix
```

The installation will automatically prompt for any input, installing a base configuration. \
Afterwards, reboot to check if LUKS is setup correctly, after which the base setup within [README.md](../../README.md) can be run!

```bash
./hosts/workstation/setup/install.sh
```

Also, if the UEFI of my motherboard should be reset, I can restore the settings using the following backup.

```bash
sops ./hosts/workstation/hardware/profile > ~/Desktop/profile
```

</details>
