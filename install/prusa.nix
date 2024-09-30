{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ prusa-slicer ];
}
