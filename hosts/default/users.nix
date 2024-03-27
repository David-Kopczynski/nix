{ config, pkgs, ... }:

{
    # User configuration
    users.users.user = {
        isNormalUser = true;
        description = "David Kopczynski";
        extraGroups = [ "networkmanager" "wheel" ];
    };
}
