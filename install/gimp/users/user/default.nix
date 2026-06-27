{ user }:

{
  home-manager.users.${user} = { pkgs, ... }: {

    home.packages = with pkgs; [ gimp ];
  };
}
