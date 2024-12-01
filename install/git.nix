{ config, ... }:

{
  programs.git.enable = true;

  home-manager.users.${config.user}.programs.git = {
    inherit (config.programs.git) enable;

    userName = "David E. C. Kopczynski";
    userEmail = "david.kop.dk@gmail.com";
  };
}
