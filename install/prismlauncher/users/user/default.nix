{ user }:

{
  home-manager.users.${user} = { ... }: {

    programs.prismlauncher.enable = true;
  };
}
