(import "${(import ../../../npins).home-manager}/modules" {

  configuration = {

    home.homeDirectory = "/tmp";
    home.stateVersion = "18.09";
    home.username = "_";
  };
  pkgs = import (import ../../../npins).nixpkgs { };
}).options
