{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ tldr ];
}
