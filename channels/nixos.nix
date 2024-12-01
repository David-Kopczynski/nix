{ config, ... }:

{
  # Allow unfree packages
  nixpkgs.config = import ../resources/nixpkgs/config.nix;

  home-manager.users.${config.user}.xdg.configFile."nixpkgs/config.nix".source = ../resources/nixpkgs/config.nix;
}
