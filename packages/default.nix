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
        powertop
        qemu quickemu virt-viewer               # Install and run with `quickget windows 11` & `quickemu --vm windows-11.conf`

        # ---------- Tools ---------- #
        python3
        ghc
        texliveFull
        openconnect
        nodejs
        bitwarden-cli                           # Install with `bw login`

        # ---------- Gnome ---------- #
        gnomeExtensions.clipboard-history
        gnomeExtensions.noannoyance-fork
        gnomeExtensions.smile-complementary-extension
        gnomeExtensions.color-picker

        # ---------- Programs ---------- #
        spotify
        pdfarranger
        thunderbird
        libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE
        gimp darktable
        mpv
        kicad
        anki-bin
        soundux
        ungoogled-chromium

        unstable.smile                          # Currently only available in unstable
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
    # see https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
    environment.gnome.excludePackages = with pkgs.gnome; [
        pkgs.gnome-tour             # tour of GNOME
        yelp                        # help browser
        epiphany                    # web browser
        pkgs.gnome-text-editor      # text editor
        gnome-characters            # character browser
        geary                       # email client
        totem                       # video player
    ];
}
