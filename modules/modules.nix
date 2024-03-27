{ config, pkgs, ... }:

{
    imports = [
        <home-manager/nixos>
    ];

    # Modules that are installed on system level
    environment.systemPackages = with pkgs; [
        home-manager
    ];
}
