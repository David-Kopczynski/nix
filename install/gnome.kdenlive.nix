{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ libsForQt5.kdenlive ];

  # Enable KDE Connect
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = with pkgs; gnomeExtensions.gsconnect;

  home-manager.users."user".dconf = {
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
