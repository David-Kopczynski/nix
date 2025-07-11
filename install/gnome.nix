{ pkgs, ... }:

{
  # Enable windowing system
  services.xserver.enable = true;

  # Enable gnome desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.banner = ''
    Welcome back, David E. C. Kopczynski B.Sc.!
  '';
  services.xserver.desktopManager.gnome.enable = true;

  # fixes: https://github.com/NixOS/nixpkgs/issues/234265
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ] ++ [ yelp ];
}
