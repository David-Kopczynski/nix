{ ... }:

{
  # GameMode can be enabled with `gamemoderun ./game`
  # some applications may wrap the game automatically, while others like steam require `gamemoderun %command%`
  programs.gamemode.enable = true;

  users.users.user.extraGroups = [ "gamemode" ];
}
