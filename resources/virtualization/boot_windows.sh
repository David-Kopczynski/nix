#!/usr/bin/env nix-shell
#! nix-shell -i bash -p virt-manager
set -o errexit
set -o nounset
set -o pipefail

# Start Windows VM
echo "starting vm..."
virsh -c   qemu:///system start \
  --domain gpu-passthrough-windows-vm
