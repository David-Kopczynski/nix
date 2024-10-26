{ ... }:

{
  # Enable windowing system
  services.xserver.enable = true;

  # Enable gnome desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Wayland related settings
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
