{ pkgs, ... }:

{
  # Enable windowing system
  services.xserver.enable = true;

  # Enable gnome desktop
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.banner = "Welcome back, David E. C. Kopczynski B.Sc.!";
  services.desktopManager.gnome.enable = true;

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ] ++ [ yelp ];
}
