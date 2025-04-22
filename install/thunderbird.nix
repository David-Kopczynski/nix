{ pkgs, ... }:

{
  home-manager.users."user".programs.thunderbird.enable = true;
  home-manager.users."user".programs.thunderbird.package =
    with pkgs;
    thunderbird.override {

      # Install required extensions
      # updated in: https://github.com/nix-community/home-manager/issues/5654
      # todo: update to native home-manager config with 25.5
      extraPolicies.ExtensionSettings = {
        "de-DE@dictionaries.addons.mozilla.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/dictionary-german/latest.xpi";
        };
      };
    };
  home-manager.users."user".programs.thunderbird = {

    profiles."default".isDefault = true;
    settings = {
      # Mail composition
      "mail.identity.default.reply_on_top" = 1;

      "mail.SpellCheckBeforeSend" = true;
      "spellchecker.dictionary" = "en-US,de-DE";
    };
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

    # fixed in: https://github.com/nix-community/home-manager/commit/26ccff08df360afd888b08633a5dddbb99f04d8f
    # todo: remove this with 25.5
    thunderbird.settings = id: {
      "mail.smtpserver.smtp_${id}.authMethod" = 10;
      "mail.server.server_${id}.authMethod" = 10;
    };
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
