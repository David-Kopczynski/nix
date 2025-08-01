{ pkgs, ... }:

{
  # TODO: remove with release 25.11
  nixpkgs.overlays = [
    (final: prev: {
      gdm =
        with pkgs.unstable;
        gdm.overrideAttrs (old: {
          passthru = old.passthru // {
            initialVT = "1";
          };
        });
    })
  ];

  # Enable windowing system
  services.xserver.enable = true;

  # Enable gnome desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.banner = ''
    Welcome back, David E. C. Kopczynski B.Sc.!
  '';
  services.xserver.desktopManager.gnome.enable = true;

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ] ++ [ yelp ];
}
