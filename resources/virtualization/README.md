# 🪟 Windows
I dont like the concept of kernel-level anti-cheat, so... I just use a cheesy workaround. The containing files pose as configuration for the Windows VM, with a initial installer script in case I need to reinstall it!

## 🚀 Setup
Creation of the Windows VM is as simple as running the following command:

```bash
./create_windows.sh
```

Afterwards, the cdrom should be removed via `virsh -c qemu:///system edit gpu-passthrough-windows-vm` (removing the `<disk type='file' device='cdrom'>...</disk>` entry) and the VM is good to go!
After booting the VM, you may add USB devices as described in the next section.

## 🖥️ Usage
Starting the Windows VM any other time is just as easy:

```bash
./boot_windows.sh
```

*Note: When making changes to the VM, please keep the `./create_windows.sh` script up-to-date by using `--dry-run --print-xml` with `virt-install` and copying the output to `virsh edit -c qemu:///system gpu-passthrough-windows-vm`.*

As only the GPU is passed through, no USB devices are available in the VM. Adding them is as simple as running the following command:

```bash
./add_usb.sh
```

*Note: This requires to ssh into the host machine once to add USB devices persistently.*

### ⚒️ Hardware Tweaks
If you do not have my literal hardware setup, you may have to change the `pci_0000_0x_00_y` entries within `../install/virtualization.nix` and `./create_windows.sh` to match your GPU hardware config. You can find the PCI IDs of your device by running `lspci -nn`.
Also, `--vcpus` should be set to a value close to your limit of CPU cores, as well as `--memory` to your RAM limit!

---

Credits to [Astrid](https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/) for good hints and tips in regards to GPU passthrough with NixOS and libvirt.
