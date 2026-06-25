{ user }:

{
  home-manager.users.${user} = { config, ... }: {

    programs.git.enable = true;
    programs.git = {

      # General
      settings."user"."name" = "David E. C. Kopczynski";
      settings."user"."email" = "mail@davidkopczynski.com";

      settings."init"."defaultBranch" = "main";
      settings."pull"."rebase" = false;

      # Signing
      signing.format = "ssh";
      signing.key = builtins.readFile "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signing.signByDefault = true;
    };
  };
}
