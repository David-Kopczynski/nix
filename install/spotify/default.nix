{ lib, ... }:

{
  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = lib.toList "spotify";
}
