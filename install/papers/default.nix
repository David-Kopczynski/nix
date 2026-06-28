{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ papers ];
}
