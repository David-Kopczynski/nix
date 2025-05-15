{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam = {

    # General configuration
    extraCompatPackages = with pkgs.unstable; [ proton-ge-bin ];
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  # Steam Game Recording on tmpfs (with my own steam id)
  fileSystems."/home/user/.local/share/Steam/userdata/307220304/gamerecordings" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "size=16G"
      "nodev"
      "nosuid"
      "noswap"
      "uid=${config.users.users."user".name}"
      "gid=${config.users.groups."users".name}"
      "mode=755"
    ];
  };

  # Gaming Optimizations
  # Simply add to Steam `LAUNCH OPTIONS` or start game with: "gaming-mode %command%"
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "gaming-mode";
      text = ''
        gamemoderun "$@"
      '';
    })
  ];

  programs.gamemode.enable = true;
  users.users."user".extraGroups = [ "gamemode" ];
}
