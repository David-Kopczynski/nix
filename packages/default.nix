{ config, pkgs, ... }:

let
    # Allow unstable packages
    unstable = import <unstable> { config = { allowUnfree = true; }; };
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

        # ---------- Games ---------- #
        prismlauncher
        heroic
        unstable.r2modman
    ];
}
