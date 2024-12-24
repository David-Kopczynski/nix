{ config, ... }:

{
  # User configuration
  users.users.${config.user} = {
    isNormalUser = true;
    description = "David Kopczynski";
    extraGroups = [ "wheel" ];
  };
}
