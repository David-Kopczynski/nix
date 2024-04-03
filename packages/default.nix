{ config, pkgs, ... }:

let
    # Allow unstable packages
    unstable = import (builtins.fetchGit {
        name = "nixpkgs-unstable";
        url = https://github.com/nixos/nixpkgs/;
        ref = "nixos-unstable";
    }) { config = { allowUnfree = true; }; };
in {
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

        # ---------- Gnome ---------- #
        gnomeExtensions.clipboard-history
        gnomeExtensions.noannoyance-fork

        # ---------- Programs ---------- #
        spotify
        pdfarranger
        webex

        unstable.vscode
        unstable.discord
        unstable.wootility

        # ---------- Games ---------- #
        # see https://www.protondb.com/ for compatibility
        unstable.prismlauncher
        unstable.heroic
        unstable.lutris
        unstable.r2modman
    ];
}
