{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [ color-picker ];

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [ color-picker.extensionUuid ];
    };
  };
}
