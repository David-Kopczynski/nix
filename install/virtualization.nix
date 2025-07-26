{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  boot.kernelParams = [ "intel_iommu=on" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd = {

    # TPM emulation for Windows VM
    qemu.swtpm.enable = true;

    # Single GPU passthrough hook for Windows VM
    hooks.qemu."gpu-passthrough-windows-vm" = "${
      pkgs.writeShellApplication {

        name = "gpu-passthrough-windows-vm";
        runtimeInputs = with pkgs; [ libvirt ];
        text = ''
          if [[ $1 == "gpu-passthrough-windows-vm" && $2 == "prepare" && $3 == "begin" ]]; then

            # Stop GNOME
            systemctl stop display-manager.service

            # Setup vfio
            echo 0 > /sys/class/vtconsole/vtcon0/bind
            modprobe --wait 60000 -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

            virsh nodedev-detach pci_0000_01_00_0
            virsh nodedev-detach pci_0000_01_00_1
            virsh nodedev-detach pci_0000_01_00_2
            virsh nodedev-detach pci_0000_01_00_3
            modprobe --wait 60000 vfio-pci

            # Setup networking
            if [[ "$(virsh net-info --network default)" =~ Active:[[:space:]]+no ]]; then virsh net-start --network default; fi
          fi

          if [[ $1 == "gpu-passthrough-windows-vm" && $2 == "release" && $3 == "end" ]]; then

            # Setup nvidia
            modprobe --wait 60000 -r vfio-pci
            virsh nodedev-reattach pci_0000_01_00_0
            virsh nodedev-reattach pci_0000_01_00_1
            virsh nodedev-reattach pci_0000_01_00_2
            virsh nodedev-reattach pci_0000_01_00_3

            modprobe --wait 60000 nvidia_drm nvidia_modeset nvidia_uvm nvidia
            echo 1 > /sys/class/vtconsole/vtcon0/bind

            # Start GNOME
            systemctl start display-manager.service
          fi
        '';
      }
    }/bin/gpu-passthrough-windows-vm";
  };
}
