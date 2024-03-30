{ config, pkgs, ... }:

{
    imports = [

        # Envorinment variables
        ./.env.nix

        # Default system configuration
        ./hosts/default
        ./hosts

        # Packages, programs and services
        ./packages
        ./programs
        ./services
    ];

    # Custom commands and functions
    environment.systemPackages = [
        (import ./commands/please.nix { inherit config pkgs; })
    ];
}
