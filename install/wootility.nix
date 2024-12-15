{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ wootility ];

  hardware.wooting.enable = true;
  users.users.${config.user} = {

    # Allow access to keyboard peripherals
    extraGroups = [ "input" ];
  };
}
