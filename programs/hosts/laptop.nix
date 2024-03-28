{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "laptop") {

    # Programs installed with possibly custom configuration
    # Options can be found in https://search.nixos.org/options
    programs = {

    };
}
