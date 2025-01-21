{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ wootility ];

  # Allow connection to keyboard
  hardware.wooting.enable = true;
  users.users."user".extraGroups = [ "input" ];
}
