{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnomeExtensions.bluetooth-battery-meter ];

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [ gnomeExtensions.bluetooth-battery-meter.extensionUuid ];
    };

    # Custom settings
    settings."org/gnome/shell/extensions/Bluetooth-Battery-Meter" = {
      enable-battery-level-text = true;
      level-indicator-color = 0;
    };
  };
}
