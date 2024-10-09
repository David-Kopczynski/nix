{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ libsForQt5.kdenlive ];

  # Enable KDE Connect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  home-manager.users.user.dconf = {
    # Do not enable by default: this retains the current behavior

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [ gsconnect.extensionUuid ];
    };

    # Configuration
    settings."org/gnome/shell/extensions/gsconnect" = {
      devices = [ "phone" ];
      enabled = true;
      id = "${config.host}";
      name = "${config.host}";
    };

    settings."org/gnome/shell/extensions/gsconnect/device/workstation" = {
      name = "nixos-workstation";
      type = "desktop";
    };

    settings."org/gnome/shell/extensions/gsconnect/device/laptop" = {
      name = "nixos-laptop";
      type = "laptop";
    };

    settings."org/gnome/shell/extensions/gsconnect/device/phone" = {
      certificate-pem = "-----BEGIN CERTIFICATE-----\n***REMOVED***\n-----END CERTIFICATE-----\n";
      name = "Galaxy S10";
      type = "phone";
    };
    settings."org/gnome/shell/extensions/gsconnect/device/phone/plugin/clipboard" = {
      receive-content = true;
      send-content = true;
    };
  };
}
