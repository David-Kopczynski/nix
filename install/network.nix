{ config, ... }:

{
  # Enable networking
  networking.hostName = "nixos-${config.host}";
  networking.networkmanager.enable = true;
  users.users.${config.user} = {
    extraGroups = [ "networkmanager" ];
  };
}
