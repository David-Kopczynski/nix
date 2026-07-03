# ❄️ Laptop
My Framework 13 (Intel 13th Gen.) `laptop` is installed with a LUKS setup, running a LVM with ext4. \
Unlocking the LUKS partition is done with a YubiKey, configured with the help of a declarative `disko` setup!

<details>
<summary>🔨 Installation</summary>

Start by going through the NixOS graphical installer, selecting the appropriate keyboard layout to allow us to proceed to the terminal. \
We wont be installing NixOS the classic way, but rather download this repository to get everything up and running:

```bash
git clone https://github.com/David-Kopczynski/nix.git
cd nix
```

First, we need to get the YubiKey in a valid state for fido2. \
Afterwards, the installation can be run, automatically prompting for any input and installing a base configuration.

```bash
./hosts/laptop/setup/prepare_yubikey.sh
./hosts/laptop/setup/install.sh
```

Finally, reboot to check if LUKS is setup correctly, after which the base setup within [README.md](../../README.md) can be run!

</details>
