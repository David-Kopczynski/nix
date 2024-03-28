{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "workstation") {

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List of packages installed in system scope
    # Packages can be found in https://search.nixos.org/packages
    # or with `nix search <package>`
    environment.systemPackages = with pkgs; [

    ];
}
