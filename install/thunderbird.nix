{ pkgs, ... }:

{
  programs.thunderbird.enable = true;
  programs.thunderbird = {

    # General settings
    preferences."mailnews.mark_message_read.auto" = false;
    preferences."mail.identity.default.reply_on_top" = 1;
    preferences."mail.SpellCheckBeforeSend" = true;
    preferences."spellchecker.dictionary" = "en-US,de-DE";

    # Email accounts
    preferences."mail.accountmanager.accounts" = "account_IONOS,account_GMAIL,account_RWTH,account1";
    preferences."mail.smtpservers" = "smtp_IONOS,smtp_GMAIL,smtp_RWTH";

    preferences."mail.accountmanager.defaultaccount" = "account_IONOS";
    preferences."mail.smtp.defaultserver" = "smtp_IONOS";

    preferences."mail.account.account_IONOS.identities" = "id_IONOS";
    preferences."mail.account.account_IONOS.server" = "server_IONOS";
    preferences."mail.identity.id_IONOS.fullName" = "David Kopczynski";
    preferences."mail.identity.id_IONOS.useremail" = "mail@davidkopczynski.com";
    preferences."mail.identity.id_IONOS.smtpServer" = "smtp_IONOS";
    preferences."mail.identity.id_IONOS.valid" = true;
    preferences."mail.server.server_IONOS.name" = "Personal";
    preferences."mail.server.server_IONOS.userName" = "mail@davidkopczynski.com";
    preferences."mail.server.server_IONOS.port" = 993;
    preferences."mail.server.server_IONOS.type" = "imap";
    preferences."mail.server.server_IONOS.hostname" = "imap.ionos.de";
    preferences."mail.server.server_IONOS.socketType" = 3;
    preferences."mail.server.server_IONOS.login_at_startup" = true;
    preferences."mail.smtpserver.smtp_IONOS.username" = "mail@davidkopczynski.com";
    preferences."mail.smtpserver.smtp_IONOS.port" = 587;
    preferences."mail.smtpserver.smtp_IONOS.hostname" = "smtp.ionos.de";
    preferences."mail.smtpserver.smtp_IONOS.try_ssl" = 2;
    preferences."mail.smtpserver.smtp_IONOS.authMethod" = 3;

    preferences."mail.account.account_GMAIL.identities" = "id_GMAIL";
    preferences."mail.account.account_GMAIL.server" = "server_GMAIL";
    preferences."mail.identity.id_GMAIL.fullName" = "David Kopczynski";
    preferences."mail.identity.id_GMAIL.useremail" = "david.kop.dk@gmail.com";
    preferences."mail.identity.id_GMAIL.smtpServer" = "smtp_GMAIL";
    preferences."mail.identity.id_GMAIL.valid" = true;
    preferences."mail.server.server_GMAIL.name" = "Google Mail";
    preferences."mail.server.server_GMAIL.userName" = "david.kop.dk@gmail.com";
    preferences."mail.server.server_GMAIL.port" = 993;
    preferences."mail.server.server_GMAIL.type" = "imap";
    preferences."mail.server.server_GMAIL.hostname" = "imap.gmail.com";
    preferences."mail.server.server_GMAIL.socketType" = 3;
    preferences."mail.server.server_GMAIL.is_gmail" = true;
    preferences."mail.server.server_GMAIL.authMethod" = 10;
    preferences."mail.server.server_GMAIL.login_at_startup" = true;
    preferences."mail.smtpserver.smtp_GMAIL.username" = "david.kop.dk@gmail.com";
    preferences."mail.smtpserver.smtp_GMAIL.port" = 465;
    preferences."mail.smtpserver.smtp_GMAIL.hostname" = "smtp.gmail.com";
    preferences."mail.smtpserver.smtp_GMAIL.try_ssl" = 3;
    preferences."mail.smtpserver.smtp_GMAIL.authMethod" = 10;

    preferences."mail.account.account_RWTH.identities" = "id_RWTH";
    preferences."mail.account.account_RWTH.server" = "server_RWTH";
    preferences."mail.identity.id_RWTH.fullName" = "David Kopczynski";
    preferences."mail.identity.id_RWTH.useremail" = "david.kopczynski@rwth-aachen.de";
    preferences."mail.identity.id_RWTH.smtpServer" = "smtp_RWTH";
    preferences."mail.identity.id_RWTH.valid" = true;
    preferences."mail.server.server_RWTH.name" = "RWTH Aachen";
    preferences."mail.server.server_RWTH.userName" = "hg066732@rwth-aachen.de";
    preferences."mail.server.server_RWTH.port" = 993;
    preferences."mail.server.server_RWTH.type" = "imap";
    preferences."mail.server.server_RWTH.hostname" = "mail.rwth-aachen.de";
    preferences."mail.server.server_RWTH.socketType" = 3;
    preferences."mail.server.server_RWTH.login_at_startup" = true;
    preferences."mail.smtpserver.smtp_RWTH.username" = "hg066732@rwth-aachen.de";
    preferences."mail.smtpserver.smtp_RWTH.port" = 587;
    preferences."mail.smtpserver.smtp_RWTH.hostname" = "mail.rwth-aachen.de";
    preferences."mail.smtpserver.smtp_RWTH.try_ssl" = 2;
    preferences."mail.smtpserver.smtp_RWTH.authMethod" = 3;

    # Extensions
    policies.ExtensionSettings."de-DE@dictionaries.addons.mozilla.org" = {
      installation_mode = "force_installed";
      install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/dictionary-german/latest.xpi";
    };
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ geary ];
}
