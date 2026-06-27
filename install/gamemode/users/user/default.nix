{ user }:

{
  users.users.${user}.extraGroups = [ "gamemode" ];

  home-manager.users.${user} = { pkgs, ... }: {

    # Simply add to Steam `LAUNCH OPTIONS` or start game with: "gaming-mode %command%"
    home.packages = [
      (pkgs.writeShellApplication {
        name = "gaming-mode";
        text = ''gamemoderun "$@"'';
      })
    ];
  };
}
