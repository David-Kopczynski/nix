{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ suyu ];
}
