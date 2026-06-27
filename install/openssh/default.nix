{ ... }:

{
  services.openssh.enable = true;
  services.openssh = {

    # General
    authorizedKeysInHomedir = false;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };
}
