{ config, pkgs, ... }:

{
    # User configuration
    users.users.user = {
        isNormalUser = true;
        description = "David Kopczynski";
        extraGroups = [
            "networkmanager" "wheel"    # Default groups
            "dialout"                   # Serial port access with PlatformIO
            "input"                     # Access to input devices with Wootility
        ];
    };
}
