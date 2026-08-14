{ ... }:

{
  programs.steam.enable = true;
  programs.steam = {

    # General configuration
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = [ "steam" ] ++ [ "steam-unwrapped" ];
}
