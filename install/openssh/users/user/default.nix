{ user }:
{ config, ... }:

{
  # Allow login using own keys
  users.users.${user}.openssh.authorizedKeys.keyFiles = [
    (/. + config.home-manager.users.${user}.home.homeDirectory + /.ssh/id_ed25519.pub)
  ];
}
