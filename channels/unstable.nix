{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {

    # Use the same configuration as the current NixOS
    config = config.nixpkgs.config;
  };
in
{
  # Expose unstable channel by using `pkgs.unstable`
  nixpkgs.config = {
    packageOverrides = pkgs: { unstable = unstable; };
  };
}
