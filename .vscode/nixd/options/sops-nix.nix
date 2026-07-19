(import "${(import ../../../npins).sops-nix}/modules/sops" rec {

  config = { };
  lib = pkgs.lib;
  options = { };
  pkgs = import (import ../../../npins).nixpkgs { };
}).options
