{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ showtime ];
}
