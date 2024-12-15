{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ nav ];

  # Setup nav correctly
  programs.bash.shellInit = "eval \"$(nav --init bash)\"";
  programs.zsh.shellInit = "eval \"$(nav --init zsh)\"";
}
