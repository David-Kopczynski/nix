{ config, ... }:

{
  programs.git.enable = true;

  home-manager.users."user".programs.git = {
    inherit (config.programs.git) enable;

    userName = "David E. C. Kopczynski";
    userEmail = "david.kop.dk@gmail.com";

    extraConfig.pull.rebase = false;

    extraConfig.gpg.format = "ssh";
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPLqP71iBRAFd7OFIjlkN6yGEr++G5eRDJ+U57R9f8e user@nixos";
    signing.signByDefault = true;
  };
}
