{ pkgs, ... }:

{
  boot.kernelPackages = with pkgs.linuxKernel.packages; linux_zen;
}
