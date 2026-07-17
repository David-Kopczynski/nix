(import <home-manager/modules> {

  configuration = {

    home.homeDirectory = "/tmp";
    home.stateVersion = "18.09";
    home.username = "_";
  };
  pkgs = import <nixpkgs> { };
}).options
