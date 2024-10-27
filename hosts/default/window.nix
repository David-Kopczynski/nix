{ ... }:

{
  # Enable windowing system
  services.xserver.enable = true;

  # Enable gnome desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.banner = ''
    Welcome back, David E. C. Kopczynski B.Sc.!
  '';
  services.xserver.desktopManager.gnome.enable = true;
}
