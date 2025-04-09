{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ nav ];

  programs.bash.shellInit = "eval \"$(nav --init bash)\"";
  programs.zsh.shellInit = "eval \"$(nav --init zsh)\"";
}
