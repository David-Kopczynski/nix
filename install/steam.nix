{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam = {

    # General configuration
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  # Gaming Optimizations
  # Simply add to Steam `LAUNCH OPTIONS` or start game with: "gaming-mode %command%"
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "gaming-mode";
      text = ''
        gamescope -W 2560 -H 1440 -r 165 -f --adaptive-sync --immediate-flips --rt -- gamemoderun "$@"
      '';
    })
  ];

  programs.gamemode.enable = true;
  programs.steam.gamescopeSession.enable = true;

  users.users."user".extraGroups = [ "gamemode" ];
}
