{ config, lib, ... }:

{
  networking.hostName = "nixos-${config.system.name}";
  networking.networkmanager.enable = true;

  users.users."user".extraGroups = [ "networkmanager" ];

  # Custom DNS (cloudflare malware blocking)
  networking.nameservers = [
    "2606:4700:4700::1112"
    "2606:4700:4700::1002"
    "1.1.1.2"
    "1.0.0.2"
  ];

  # Declarative wifi configuration
  sops.secrets."wifi.env" = { };
  networking.networkmanager.ensureProfiles.environmentFiles = [ config.sops.secrets."wifi.env".path ];

  networking.networkmanager.ensureProfiles.profiles =
    lib.genAttrs
      [
        "Father"
        "Home"
        "Hotspot"
        "Mother"
      ]
      (name: {
        connection = {
          id = "\$${name}_SSID";
          type = "wifi";
        };

        wifi = {
          mode = "infrastructure";
          ssid = "\$${name}_SSID";
        };

        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "\$${name}_PSK";
        };
      })
    // {
      "University" = {
        connection = {
          id = "eduroam";
          type = "wifi";
        };

        wifi = {
          mode = "infrastructure";
          ssid = "eduroam";
        };

        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-eap";
        };

        "802-1x" = {
          eap = "pwd";
          identity = "$University_IDENT";
          password = "$University_PSK";
        };
      };
    };
}
