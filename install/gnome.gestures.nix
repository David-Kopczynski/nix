{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [ x11-gestures ];

  # Enable multi-touch gestures
  services.touchegg.enable = true;

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [ x11-gestures.extensionUuid ];
    };
  };
}
