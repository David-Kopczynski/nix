{ config, pkgs, ... }:

{
    imports = [

        # Host dependent configuration
        ../laptop.nix
        ../workstation.nix

        # Import all used NixOS modules
        ./kde.nix
        ./locale.nix
        ./network.nix
        ./sound.nix
        ./system.nix
        ./users.nix
    ];
}
