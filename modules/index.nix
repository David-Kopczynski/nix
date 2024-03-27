{ config, pkgs, ... }:

{
    imports = [
        ./modules.nix
        ./hosts/laptop.nix
        ./hosts/pc.nix
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [

        # System
        pass
        git
        openssh

        # Generic
        wget
        neovim
        python3
        
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
