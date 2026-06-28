{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ snapshot ];
}
