{ lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePackages = map lib.getName (with pkgs; [ spotify ]);
}
