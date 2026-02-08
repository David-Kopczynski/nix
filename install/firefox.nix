{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.firefox.enable = true;
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

    # Default search engine
    SearchEngines.Default = "Google";
  };
  programs.firefox.preferences = {

    # General
    "browser.aboutConfig.showWarning" = false;
    "browser.sessionstore.max_resumed_crashes" = -1;
    "browser.translations.automaticallyPopup" = false;
  };

  # Firefox as default browser
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = lib.genAttrs [
    "text/html"
    "x-scheme-handler/about"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/unknown"
  ] (_: "firefox.desktop");

  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;

  # Main application
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/shell" = {
      favorite-apps = [ "firefox.desktop" ];
    };
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ epiphany ];
}
