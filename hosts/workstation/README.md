# ❄️ Workstation
My **i7 13700kf** + **RTX 2070 Super** `workstation` is installed with a LUKS setup, running a LVM with ext4. \
Unlocking the LUKS partition is done with a password, configured with the help of a declarative `disko` setup!

### 🖥️ Motherboard
*Sadly*, motherboards are stateful and need basic configuration for fans, security, and performance features. \
In case the UEFI should be reset, I can restore the settings using my sops encrypted backup!

```bash
sudo sops ./hosts/workstation/hardware/profile > /boot/profile
```
