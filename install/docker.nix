{ config, ... }:

{
  virtualisation.docker.enable = true;

  users.users.${config.user} = {

    # Allow rootless Docker
    extraGroups = [ "docker" ];
  };
}
