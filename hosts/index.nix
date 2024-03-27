{ config, pkgs, ... }:

{
    # Import host specific configuration
    imports = [ 
        ./default/index.nix 
        ./laptop/index.nix
        ./pc/index.nix
    ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "23.11";
}
