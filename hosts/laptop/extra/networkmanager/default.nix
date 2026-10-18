{ config, lib, ... }:

{
  networking.networkmanager.ensureProfiles.profiles."wg0" = {

    # General
    connection.id = "Home VPN";
    connection.type = "wireguard";
    connection."interface-name" = "wg0";

    # Basics
    "wireguard"."private-key" = "$PRIVATE_KEY";

    # IPv4
    "ipv4"."method" = "manual";
    "ipv4"."address1" = "10.0.100.3/32";

    # IPv6
    "ipv6"."method" = "manual";
    "ipv6"."address1" = "fd00:100::3/128";

    # DNS
    "ipv4"."dns" = "10.4.10.107;10.0.100.1;";
    "ipv4"."dns-search" = "~";

    # Server
    "wireguard-peer.8ar58XsPuiPEgW3iCOOY1Zj//k/+BndoRehvtcFZhls=" = {

      # Target
      "endpoint" = "vpn.davidkopczynski.com:51820";
      "allowed-ips" = "0.0.0.0/0;::/0;";

      # Additional authentication
      "preshared-key" = "$SHARED_KEY";
      "preshared-key-flags" = 0;
    };
  };

  # Import secrets
  networking.networkmanager.ensureProfiles.environmentFiles =
    lib.toList
      config.sops.templates."wg0".path;

  # Secrets
  sops.templates."wg0".content = ''
    PRIVATE_KEY=${config.sops.placeholder."wg0/private"}
    SHARED_KEY=${config.sops.placeholder."wg0/shared"}
  '';
  sops.secrets."wg0/private".sopsFile = ./secrets.yaml;
  sops.secrets."wg0/shared".sopsFile = ./secrets.yaml;
}
