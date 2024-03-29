{ config, pkgs, ... }:

{
    imports = [

        # Host dependent configuration
        ../laptop.nix
        ../workstation.nix

        # Import all used NixOS modules
        ./locale.nix
        ./network.nix
        ./sound.nix
        ./system.nix
        ./users.nix
        ./window.nix
    ];
}
