{ ... }:

{
  services.fail2ban.enable = true;
  services.fail2ban = {

    # General
    bantime-increment.enable = true;
  };
}
