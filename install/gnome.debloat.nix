{ pkgs, ... }:

{
  # Remove unnecessary gnome applications
  environment.gnome.excludePackages = with pkgs.gnome; [ pkgs.gnome-tour yelp ];
}
