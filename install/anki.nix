{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ anki-bin ];
}
