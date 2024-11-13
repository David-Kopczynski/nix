{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ./../derivations/nav.nix { })
  ];
}
