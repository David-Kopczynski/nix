{ user }:

{
  home-manager.users.${user} = { pkgs, ... }: {

    home.packages = with pkgs; [ r2modman ];
  };
}
