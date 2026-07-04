{ config, lib, ... }:

{
  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = map lib.getName [
    config.hardware.nvidia.package
  ];
}
