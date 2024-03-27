{ config, pkgs, ... }:

{
    imports = [
        ./modules.nix
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [

        # Generic
        git
        openssh
        neovim

        # Programs
        vscode
        firefox
        discord
        spotify

        # Gaming
        steam
        prismlauncher
    ];

    # Programs with additional settings
    programs.steam = {
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };

    # Services to enable
    services.printing.enable = true; # CUPS to print documents
}
