{ config, pkgs, ... }:

{
    # Host specific configuration
    imports = [
        ./hosts/laptop.nix
        ./hosts/workstation.nix
    ];

    # Programs installed with possibly custom configuration
    # Options can be found in https://search.nixos.org/options
    programs = {

        # ---------- System ---------- #
        git.enable = true;

        # ---------- Tools ---------- #
        neovim.enable = true;

        # ---------- Programs ---------- #
        firefox.enable = true;

        # ---------- Games ---------- #
        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };
    };
}
