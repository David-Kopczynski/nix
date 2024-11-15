{ ... }:

{
  virtualisation.docker.enable = true;

  users.users.user = {

    # Allow rootless Docker
    extraGroups = [ "docker" ];
  };
}
