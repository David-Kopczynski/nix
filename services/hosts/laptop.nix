{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "laptop") {

  # Services started with possible configuration
  # Options can be found in https://search.nixos.org/options
  services = { };
}
