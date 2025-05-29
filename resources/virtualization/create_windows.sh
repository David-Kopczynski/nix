#!/usr/bin/env nix-shell
#! nix-shell -i bash -p virt-manager
set -o errexit
set -o nounset
set -o pipefail

# Read Windows inputs for creation
read -rep "Windows ISO Path: " windows_iso_path; if [[ ! -f "$windows_iso_path" ]]; then echo "Error: Windows ISO file does not exist at the specified path."; exit 1; fi
read -rep "Windows Data Directory: " windows_data_dir; mkdir -p "$windows_data_dir" || { echo "Error: Could not create Windows data directory."; exit 1; }

# Create Windows VM
virt-install \
  --name          gpu-passthrough-windows-vm \
  --os-variant    win11 \
  --cdrom         "$windows_iso_path" \
  --cpu           host-passthrough \
  --vcpus         20,maxvcpus=24 \
  --memory        24576 \
  --graphics      none \
  --hostdev       pci_0000_01_00_0 \
  --hostdev       pci_0000_01_00_1 \
  --disk          path="$windows_data_dir/data.img",size=512,format=raw,cache=none \
  --network       bridge=enp5s0,model=e1000e \
  --machine       q35 \
  --tpm           emulator \
  --sysinfo       host \
  --features      kvm.hidden.state=on \
  --check         all=on \
  --print-xml \
  --dry-run

  # THESE MAY BE NEEDED IF SOMETHING DOES NOT WORK CORRECTLY
  # --noautoconsole
  # --virt-type ... \ qemu?kvm?
  # --boot          cdrom \

  # THESE ALLOW TO SET SPECIFIC XML OPTIONS
  # --metadata ... \
  # --xml ... \
  # --extra-args ... \
  # --qemu-commandline ... \

  # THESE ARE FOR INPUTS, OUTPUTS, etc.
  # --controller ... \
  # --input ... \
  # --sound ... \
  # --audio ... \

  # THESE ARE FOR LATER OPTIMIZATIONS!
  # --cputune ... \
  # --numatune ... \
  # --memtune ... \
  # --memorybacking ... \
  # --blkiotune ... \

  # THIS COULD ALLOW FOR BETTER SECURITY?
  # --launchSecurity ... \

  # THIS MAY ALLOW TO MAKE A NIXOS DECLARATIVE CONFIG FOR STARTING AS WELL
  # --transient ... \ for declarative configuration?
