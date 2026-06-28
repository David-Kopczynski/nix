{ ... }:

{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # Skip login screen for single user setup
  services.displayManager.autoLogin.user = "user";

  # Disable default applications
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;

  # Disable default wizards
  services.gnome.gnome-initial-setup.enable = false;
}
