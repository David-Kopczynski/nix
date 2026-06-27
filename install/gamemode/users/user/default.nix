{ user }:

{
  users.users.${user}.extraGroups = [ "gamemode" ];

  # Simply add to Steam `LAUNCH OPTIONS` or start game with: "gaming-mode %command%"
  home-manager.users.${user} = { pkgs, ... }: {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "gaming-mode";
        text = ''gamemoderun "$@"'';
      })
    ];
  };
}
