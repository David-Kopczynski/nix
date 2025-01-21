{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gradle
    maven
  ];
  programs.java.enable = true;
}
