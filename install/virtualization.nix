{
  config,
  pkgs,
  lib,
  ...
}:

# MAYBE ADD [ "iommu=pt" ] FOR BETTER PERFORMANCE?
# MAYBE ADD kvm,input groups?

lib.mkIf (config.system.name == "workstation") {
  boot.kernelParams = [ "intel_iommu=on" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd = {

    # TPM emulation for Windows VM
    qemu.swtpm.enable = true;

    # Single GPU passthrough hook for Windows VM
    hooks.qemu."gpu-passthrough-windows-vm" = pkgs.writeShellApplication {

      name = "gpu-passthrough-windows-vm";
      text = ''
        if [[ $1 == "gpu-passthrough-windows-vm" && $2 == "prepare" && $3 == "begin" ]]; then

          # Stop GNOME
          systemctl stop display-manager.service

          # Setup vfio
          echo 0 > /sys/class/vtconsole/vtcon0/bind
          modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

          virsh nodedev-detach pci_0000_01_00_0
          virsh nodedev-detach pci_0000_01_00_1
          modprobe vfio-pci
        fi

        if [[ $1 == "gpu-passthrough-windows-vm-stop" && $2 == "release" && $3 == "end" ]]; then

          # Setup nvidia
          modprobe -r vfio-pci
          virsh nodedev-reattach pci_0000_01_00_0
          virsh nodedev-reattach pci_0000_01_00_1

          modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia
          echo 1 > /sys/class/vtconsole/vtcon0/bind

          # Start GNOME
          systemctl start display-manager.service
        fi
      '';
    };
  };

  users.users."user".extraGroups = [ "libvirtd" ];
}
