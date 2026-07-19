{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnome-disk-utility ];
}
