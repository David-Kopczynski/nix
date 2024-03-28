{ config, pkgs, ... }:

{

    # Modules that are installed on system level
    environment.systemPackages = with pkgs; [
        konsave
    ];
}
