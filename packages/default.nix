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
        wget

        # ---------- Tools ---------- #
        python3
        texliveFull

        # ---------- Gnome ---------- #
        gnomeExtensions.clipboard-history
        gnomeExtensions.noannoyance-fork

        # ---------- Programs ---------- #
        spotify
        pdfarranger
        webex
        libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE

        unstable.vscode
        unstable.discord
        unstable.wootility

        # ---------- Games ---------- #
        unstable.prismlauncher
        unstable.heroic
        unstable.r2modman
    ];
}
