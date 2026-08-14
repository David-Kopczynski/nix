{ lib, ... }:

{
  hardware.wooting.enable = true;

  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = lib.toList "wootility";
}
