#!/usr/bin/env nix-shell
#! nix-shell -i bash -p usbutils virt-manager
set -o errexit
set -o nounset
set -o pipefail

# Print all USB devices to query
echo "Select USB device to attach:"
IFS= mapfile -t usb_devices < <(lsusb | sed -E 's/^Bus [0-9]+ Device [0-9]+: ID //')
select usb_device in "${usb_devices[@]}"; do

  # Stop interaction on invalid selection
  if [[ -z "$usb_device" ]]; then echo "done."; exit 0; fi

  # Otherwise, attach USB device to VM persistently
  echo "attaching: $usb_device..."
  virsh -c          qemu:///system attach-device \
    --live --domain gpu-passthrough-windows-vm \
    --file          <(echo "<hostdev mode='subsystem' type='usb' managed='yes'>
                              <source startupPolicy='optional'>
                                <vendor id='0x${usb_device:0:4}'/>
                                <product id='0x${usb_device:5:4}'/>
                              </source>
                            </hostdev>") \
    --persistent
done
