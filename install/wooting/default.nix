{ lib, pkgs, ... }:

{
  hardware.wooting.enable = true;

  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = map lib.getName (with pkgs; [ wootility ]);
}
