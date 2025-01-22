{ config, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  # Expose unstable channel by using `pkgs.unstable`
  nixpkgs.config.packageOverrides = pkgs: { inherit unstable; };
}
