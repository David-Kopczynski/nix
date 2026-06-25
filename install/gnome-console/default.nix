{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnome-console ];
}
