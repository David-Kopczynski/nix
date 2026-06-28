{ ... }:

{
  programs.firefox.enable = true;
  programs.firefox.policies = {

    # General
    DisableAppUpdate = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisplayBookmarksToolbar = "never";
    EnableTrackingProtection.Value = true;
    EnableTrackingProtection.Locked = true;
    EnableTrackingProtection.Cryptomining = true;
    EnableTrackingProtection.Fingerprinting = true;
    NoDefaultBookmarks = true;

    # Bitwarden Support
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    OfferToSaveLogins = false;

    # Default search engine
    SearchEngines.Default = "Google";
  };
  programs.firefox.preferences = {

    # General
    "browser.aboutConfig.showWarning" = false;
    "browser.sessionstore.max_resumed_crashes" = -1;
    "browser.translations.automaticallyPopup" = false;
  };
}
