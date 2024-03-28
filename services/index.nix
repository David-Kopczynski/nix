{ config, pkgs, ... }:

{
    # Host specific configuration
    imports = [
        ./hosts/laptop.nix
        ./hosts/workstation.nix
    ];

    # Services started with possible configuration
    # Options can be found in https://search.nixos.org/options
    services = {

        # ---------- System ---------- #
        openssh.enable = true;
        printing.enable = true;

        # ---------- Tools ---------- #
        flatpak.enable  = true;

        # ---------- Programs ---------- #

        # ---------- Games ---------- #
    };
}
