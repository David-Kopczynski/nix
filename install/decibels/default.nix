{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ decibels ];
}
