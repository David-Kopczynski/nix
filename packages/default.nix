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
        openconnect

        # ---------- Gnome ---------- #
        gnomeExtensions.clipboard-history
        gnomeExtensions.noannoyance-fork
        gnomeExtensions.smile-complementary-extension

        # ---------- Programs ---------- #
        spotify
        pdfarranger
        libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE

        unstable.smile # Currently only available in unstable
        unstable.webex
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

    # Remove packages that are installed another way
    environment.gnome.excludePackages = with pkgs.gnome; [
        epiphany                    # web browser
        pkgs.gnome-text-editor      # text editor
        gnome-characters            # character browser
    ];
}
