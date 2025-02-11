{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.firefox.package = with pkgs; firefox-esr;
  programs.firefox.policies = {

    # General
    DisableAppUpdate = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisplayBookmarksToolbar = "never";
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    NoDefaultBookmarks = true;

    # Bitwarden Support
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    OfferToSaveLogins = false;

    # Default search engine (ESR only)
    SearchEngines.Default = "Qwant";
    SearchEngines.Add = [
      {
        Name = "Qwant";
        IconURL = "https://www.qwant.com/favicon.ico";
        URLTemplate = "https://www.qwant.com/?t=web&l=en&q={searchTerms}";
        SuggestURLTemplate = "https://api.qwant.com/api/suggest?q={searchTerms}";
      }
    ];
  };
  programs.firefox.preferences = {

    # General
    "browser.aboutConfig.showWarning" = false;
    "browser.sessionstore.max_resumed_crashes" = -1;
    "browser.translations.automaticallyPopup" = false;
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    evince
  ];
}
