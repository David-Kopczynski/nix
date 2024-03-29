{ config, pkgs, ... }:

{
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
        pdfarranger

        # Wayland temp fix
        tela-circle-icon-theme
        (pkgs.makeDesktopItem {
            name = "discord";
            exec = "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
            desktopName = "Discord";
            icon = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/scalable/apps/discord.svg";
        })

        # ---------- Games ---------- #
        prismlauncher
    ];
}
