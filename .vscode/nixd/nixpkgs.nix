(import "${(import ../../../npins).nixpkgs}/nixos" {

  configuration = ../../.;
}).pkgs
