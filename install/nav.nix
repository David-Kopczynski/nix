{ config, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ./../derivations/nav.nix { })
  ];

  home-manager.users.user.programs = {
    # Setup nav correctly

    bash = {
      enable = true;
      bashrcExtra = "eval \"$(nav --init bash)\"";
    };

    zsh = {
      inherit (config.programs.zsh) enable;
      initExtra = "eval \"$(nav --init zsh)\"";
    };
  };
}
