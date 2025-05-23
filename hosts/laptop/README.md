# ❄️ Laptop
My Framework 13 (13th gen) laptop is installed with a LUKS setup, running a LVM with ext4. Unlocking the LUKS partition is done with a YubiKey, all configured with the help of a declarative `disko` setup!

## 🚀 Setup
As we are on a fresh system, we need our configuration to get started. \
Start by going through the NixOS graphical installer to select the keyboard layout and then proceed to the terminal. \
Download the repository and navigate to this directory:

```bash
git clone https://github.com/David-Kopczynski/nix.git
cd nix/hosts/laptop
```

Before installing anything on this system, make sure to have the secret configured on the YubiKey:

```bash
./luks_yubikey_generate.sh # if freshly setting up
./luks_yubikey_restore.sh  # if trying to restore secret
```

Then, to install the partition layout and the base starting configuration (after which the steps within the base [README.md](../../README.md) apply), simply run the following command:

```bash
./install.sh
```

*It is important for this process to have the YubiKey inserted, as it is used to calculate the LUKS key.* \
*Also, backup the secret used for the YubiKey as well as the seed in a safe place in case of emergency!* \
*When reusing old configurations, make sure to update the `stateVersion` in the host configuration to the latest version.* \
