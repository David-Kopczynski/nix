{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gimp
    darktable
  ];
}
