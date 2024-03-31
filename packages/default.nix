{ config, pkgs, ... }:

let
    # Allow unstable packages
    unstable = import (builtins.fetchGit {
        name = "nixpkgs-unstable";
        url = https://github.com/nixos/nixpkgs/;
        ref = "nixos-unstable";
    }) { config = { allowUnfree = true; }; };
in {
    # Host specific configuration
    imports = [
        ./hosts/laptop.nix
        ./hosts/workstation.nix
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List of packages installed in system scope
    # Packages can be found in https://search.nixos.org/packages
    # or with `nix search <package>`
    environment.systemPackages = with pkgs; [

        # ---------- System ---------- #

        # ---------- Tools ---------- #
        wget
        python3

        # ---------- Programs ---------- #
        vscode
        spotify
        discord
        pdfarranger
        gnome.gnome-calculator
        wootility

        # ---------- Games ---------- #
        prismlauncher
        heroic
        unstable.r2modman
    ];
}
