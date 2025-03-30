{ config, ... }:

{
  users.users."user" = {

    # User configuration
    description = "David Kopczynski";
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."user/password".path;
    isNormalUser = true;
  };

  # Declarative password
  users.mutableUsers = false;
  sops.secrets."user/password".neededForUsers = true;
}
