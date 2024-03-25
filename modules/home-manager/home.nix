{ config, pkgs, ... }:

{
  # General system information
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";

  # Home Manager configuration for specific programs
  programs.git = {
    enable = true;
    userName = "David E. C. Kopczynski";
    userEmail = "david.kop.dk@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
