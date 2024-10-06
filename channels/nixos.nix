{ ... }:

{
  # Allow unfree packages
  nixpkgs.config = import ../resources/nixpkgs/config.nix;

  home-manager.users.user.xdg.configFile."nixpkgs/config.nix".source = ../resources/nixpkgs/config.nix;
}
