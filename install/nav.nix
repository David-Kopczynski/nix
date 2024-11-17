{ config, pkgs, ... }:

{
  environment.systemPackages = [ (pkgs.callPackage ./../derivations/nav { }) ];

  # Setup nav correctly
  programs.bash.shellInit = "eval \"$(nav --init bash)\"";
  programs.zsh.shellInit = "eval \"$(nav --init zsh)\"";
}
