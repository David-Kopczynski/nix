{ config, pkgs, ... }:

{
    # Import all used NixOS modules
    imports = [
        ./kde.nix
        ./locale.nix
        ./network.nix
        ./sound.nix
        ./users.nix
    ];
}
