{ pkgs, ... }:

{
  programs.java.enable = true;

  # Add additional build tools
  environment.systemPackages = with pkgs; [
    gradle
    maven
  ];
}
