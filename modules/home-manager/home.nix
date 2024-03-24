{ config, pkgs, ... }:

{
  # General system information
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  # Generic packages installed to user
  home.packages = with pkgs; [];

  # Packages with additional settings
  programs.git = {
    enable = true;
    userName = "David E. C. Kopczynski";
    userEmail = "david.kop.dk@gmail.com";
  };

  programs.ssh = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
