#!/usr/bin/env nix-shell
#! nix-shell -i bash -p virt-manager
set -o errexit
set -o nounset
set -o pipefail

# Setup libvirt
echo "libvirt network setup..."
if [[ "$(virsh -c qemu:///system net-info --network default)" =~ Active:[[:space:]]+no ]]; then virsh -c qemu:///system net-start --network default; fi

# Read Windows inputs for creation
echo "libvirt vm creation..."
read -rep "Windows ISO Path: " windows_iso_path; if [[ ! -f "$windows_iso_path" ]]; then echo "Error: Windows ISO file does not exist at the specified path."; exit 1; fi
read -rep "Windows Data Directory: " windows_data_dir; mkdir -p "$windows_data_dir" || { echo "Error: Could not create Windows data directory."; exit 1; }

# Create Windows VM
virt-install \
  --connect          qemu:///system \
  --name             gpu-passthrough-windows-vm \
  --os-variant       win11 \
  --cdrom            "$windows_iso_path" \
  --cpu              host-passthrough,-hypervisor \
  --vcpus            sockets=1,cores=10,threads=2 \
  --memory           24576 \
  --qemu-commandline="-smbios type=17,manufacturer=Corsair,part=CMK48GX5M2E6000C36" \
  --graphics         none \
  --hostdev          pci_0000_01_00_0 \
  --hostdev          pci_0000_01_00_1 \
  --hostdev          pci_0000_01_00_2 \
  --hostdev          pci_0000_01_00_3 \
  --disk             path="$windows_data_dir/data.img",size=512,format=raw,bus=sata,cache=none \
  --xml              "./devices/disk[@device='disk']/product=Samsung_870_EVO" \
  --xml              "./devices/disk[@device='disk']/serial=S6PYNZ0TC14297P" \
  --network          network=default,model=e1000e \
  --machine          q35 \
  --tpm              emulator \
  --sysinfo          host \
  --features         kvm.hidden.state=on \
  --check            all=on
