{ config, lib, ... }:

{
  networking.wg-quick.interfaces."wg0" = {

    # Basic setup
    address = [ "10.0.100.3/32" ] ++ [ "fd00:100::3/128" ];
    dns = [ "10.4.10.107" ] ++ [ "10.0.100.1" ];
    privateKeyFile = config.sops.secrets."wg0/private".path;
    peers = lib.toList {
      allowedIPs = [ "0.0.0.0/0" ] ++ [ "::/0" ];
      endpoint = "vpn.davidkopczynski.com:51820";
      publicKey = "8ar58XsPuiPEgW3iCOOY1Zj//k/+BndoRehvtcFZhls=";
      presharedKeyFile = config.sops.secrets."wg0/shared".path;
    };
  };

  # Hide from GNOME
  networking.networkmanager.unmanaged = [ "interface-name:wg0" ];

  # Secrets
  sops.secrets."wg0/private".sopsFile = ./secrets.yaml;
  sops.secrets."wg0/shared".sopsFile = ./secrets.yaml;
}
