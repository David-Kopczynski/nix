{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [
    baobab
    file-roller
    gnome-connections
    gnome-contacts
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
