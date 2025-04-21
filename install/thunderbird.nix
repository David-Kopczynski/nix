{ pkgs, ... }:

{
  home-manager.users."user".programs.thunderbird.enable = true;
  home-manager.users."user".programs.thunderbird = {

    profiles."default".isDefault = true;
  };

  # Mails
  home-manager.users."user".accounts.email.accounts."Personal" = {
    primary = true;

    address = "mail@davidkopczynski.com";
    realName = "David Kopczynski";

    imap.host = "imap.ionos.de";
    imap.port = 993;
    smtp.host = "smtp.ionos.de";
    smtp.port = 587;
    smtp.tls.useStartTls = true;
    userName = "mail@davidkopczynski.com";

    thunderbird.enable = true;
  };
  home-manager.users."user".accounts.email.accounts."Google" = {

    address = "david.kop.dk@gmail.com";
    realName = "David Kopczynski";

    flavor = "gmail.com";

    thunderbird.enable = true;
  };
  home-manager.users."user".accounts.email.accounts."RWTH Aachen" = {

    address = "david.kopczynski@rwth-aachen.de";
    realName = "David Kopczynski";

    imap.host = "mail.rwth-aachen.de";
    imap.port = 993;
    smtp.host = "mail.rwth-aachen.de";
    smtp.port = 587;
    smtp.tls.useStartTls = true;
    userName = "hg066732@rwth-aachen.de";

    thunderbird.enable = true;
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ geary ];
}
