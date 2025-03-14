{ pkgs, ... }:

{
  hardware.wooting.enable = true;
  nixpkgs.overlays = [ (final: prev: { wootility = pkgs.unstable.wootility; }) ];

  # Allow connection to keyboard
  users.users."user".extraGroups = [ "input" ];
}
