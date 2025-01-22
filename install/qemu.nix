{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    virt-viewer
  ];

  # Allow USB passthrough
  virtualisation.spiceUSBRedirection.enable = true;
}
