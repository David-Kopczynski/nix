{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    virt-viewer
  ];

  virtualisation = {

    # Enable USB redirection for Spice
    spiceUSBRedirection.enable = true;
  };
}
