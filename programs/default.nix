{ config, pkgs, ... }:

{
  # Programs installed with possibly custom configuration
  # Options can be found in https://search.nixos.org/options
  programs = {

    # ---------- Tools ---------- #

    # { sort-start }
    git.enable = true;
    neovim.enable = true;
    # { sort-end }

    # ---------- Languages ---------- #

    # { sort-start }
    npm.enable = true;
    # { sort-end }

    # ---------- Programs ---------- #

    # { sort-start }
    ausweisapp.enable = true;
    ausweisapp.openFirewall = true;
    firefox.enable = true;
    noisetorch.enable = true;
    # { sort-end }

    # ---------- Games ---------- #

    # { sort-start }
    steam.dedicatedServer.openFirewall = true;
    steam.enable = true;
    steam.remotePlay.openFirewall = true;
    # { sort-end }
  };
}
