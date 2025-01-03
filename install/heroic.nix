{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ heroic ];
}
