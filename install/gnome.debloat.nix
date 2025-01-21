{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
  ];
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
}
