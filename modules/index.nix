{ config, pkgs, ... }:

{
  imports = [
    ./modules.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Generic
    git
    openssh
    neovim

    # Programs
    vscode
    firefox

    # Gaming
    steam
    minecraft
  ];

  # Programs with additional settings
  programs.steam = {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
