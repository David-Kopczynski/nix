{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ libsForQt5.kdenlive ];

  # Enable KDE Connect
  programs.kdeconnect = {
    enable = true;
    package = with pkgs; gnomeExtensions.gsconnect;
  };

  home-manager.users.${config.user}.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [ gnomeExtensions.gsconnect.extensionUuid ];
    };

    # Configuration
    settings."org/gnome/shell/extensions/gsconnect" = {
      id = "${config.host}";
      name = "${config.host}";
    };
  };
}
