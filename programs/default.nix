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
    firefox.enable = true;
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
    noisetorch.enable = true;

    # ---------- Games ---------- #
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
