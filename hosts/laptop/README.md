# ❄️ Laptop
My Framework 13 (13th gen) laptop is installed with a LUKS setup, running a LVM with ext4. Unlocking the LUKS partition is done with a YubiKey, all configured with the help of a declarative `disko` setup!

## 🚀 Setup
As we are on a fresh system, we need our configuration to get started. \
Download the repository and navigate to this directory:

```bash
git clone https://github.com/David-Kopczynski/nix.git
cd nix/hosts/laptop
```

Before installing anything on this system, make sure to have the secret configured on the YubiKey:

```bash
nix-shell luks_yubikey_generate.sh # if freshly setting up
nix-shell luks_yubikey_restore.sh  # if trying to restore secret
```

Then, to install the partition layout and the base starting configuration (after which the steps within the base [README.md](../../README.md) apply), simply run the following command:

```bash
nix-shell install.sh
```

*It is important for this process to have the YubiKey inserted, as it is used to calculate the LUKS key.* \
*Also, backup the secret used for the YubiKey in a safe place in case of emergency!*
