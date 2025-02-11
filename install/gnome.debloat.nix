{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [
    baobab
    file-roller
    gnome-contacts
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-tour
    simple-scan
    yelp
  ];
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
}
