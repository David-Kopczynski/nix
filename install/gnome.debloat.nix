{ pkgs, ... }:

{
  # Remove unnecessary gnome applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
  ];
  services.xserver.excludePackages = with pkgs; [ xterm ];
}
