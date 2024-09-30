{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ heroic ];
}
