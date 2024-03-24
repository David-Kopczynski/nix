{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
