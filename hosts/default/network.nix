{ config, pkgs, ... }:

{
    # Enable networking
    networking.hostName = "nixos-${config.host}";
    networking.networkmanager.enable = true;
}
