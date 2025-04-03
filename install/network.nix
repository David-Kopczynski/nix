{ config, ... }:

{
  networking.hostName = "nixos-${config.system.name}";
  networking.networkmanager.enable = true;

  users.users."user".extraGroups = [ "networkmanager" ];

  # Custom DNS (cloudflare malware blocking)
  networking.networkmanager.dns = "none";
  networking.nameservers = [
    "2606:4700:4700::1112"
    "2606:4700:4700::1002"
    "1.1.1.2"
    "1.0.0.2"
  ];
}
