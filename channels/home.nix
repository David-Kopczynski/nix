{ config, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.${config.user}.home.stateVersion = "24.05";
}
