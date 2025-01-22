{ config, ... }:

{
  networking.hostName = "nixos-${config.system.name}";
  networking.networkmanager.enable = true;

  users.users."user".extraGroups = [ "networkmanager" ];
}
