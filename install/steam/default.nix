{ lib, pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam = {

    # General configuration
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = map lib.getName (
    with pkgs;
    [
      steam
      steam-unwrapped
    ]
  );
}
