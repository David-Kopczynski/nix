{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ r2modman ];
}
