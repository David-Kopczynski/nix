{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ lutris ];
}
