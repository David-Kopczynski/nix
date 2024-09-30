{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ nodejs ];
  programs.npm.enable = true;
}
