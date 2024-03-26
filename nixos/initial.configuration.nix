{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Install git for ssh 
  # Remember to add SSH keys to ~/.ssh
  environment.systemPackages = with pkgs; [
    git
    openssh
  ];
}
