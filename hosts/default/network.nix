{ config, ... }:

{
  # Enable networking
  networking.hostName = "nixos-${config.host}";
  networking.networkmanager.enable = true;
  users.users.user = {
    extraGroups = [ "networkmanager" ];
  };
}
