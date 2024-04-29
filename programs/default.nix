{ config, pkgs, ... }:

{
  # Programs installed with possibly custom configuration
  # Options can be found in https://search.nixos.org/options
  programs = {

    # ---------- System ---------- #
    git.enable = true;

    # ---------- Tools ---------- #
    npm.enable = true;

    # ---------- Programs ---------- #
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
    firefox.enable = true;
    noisetorch.enable = true;

    # ---------- Games ---------- #
    steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      remotePlay.openFirewall = true;
    };
  };
}
