{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ webex ];
}
