{ pkgs, ... }:

{
  # Remove unnecessary gnome applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome.yelp
  ];
  services.xserver.excludePackages = with pkgs; [ xterm ];
}
