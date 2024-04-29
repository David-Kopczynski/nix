{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "workstation") {

  # Services started with possible configuration
  # Options can be found in https://search.nixos.org/options
  services = { };
}
