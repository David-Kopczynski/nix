{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ npins ];
}
