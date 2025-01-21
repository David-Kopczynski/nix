{ ... }:

{
  programs.steam.enable = true;
  programs.steam = {

    # General configuration
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };
}
