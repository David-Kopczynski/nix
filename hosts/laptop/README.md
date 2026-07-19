# ❄️ Laptop
My **Framework 13** (Intel 13th Gen.) `laptop` is installed with a LUKS setup, running a LVM with ext4. \
Unlocking the LUKS partition is done with a YubiKey, configured with the help of a declarative `disko` setup!

### 🔑 YubiKey
The `systemd-cryptenroll`-LUKS header needs a valid YubiKey for `fido2`. \
Provision using the following snippet for initial setup.

```bash
sudo ./hosts/laptop/setup/prepare_yubikey.sh
```
