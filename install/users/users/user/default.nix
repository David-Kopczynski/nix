{ user }:
{ config, ... }:

{
  users.users.${user} = {

    # General
    isNormalUser = true;
    description = "David Kopczynski";
    hashedPasswordFile = config.sops.secrets."${user}/password".path;

    # Administrator
    extraGroups = [ "wheel" ];
  };

  sops.secrets."${user}/password" = {

    sopsFile = ./secrets.yaml;
    neededForUsers = true;
  };
}
