{ config, pkgs, ... }:

{
  # Programs installed with possibly custom configuration
  # Options can be found in https://search.nixos.org/options
  programs = {

    # ---------- Tools ---------- #

    git.enable = true;

    # ---------- Languages ---------- #

    npm.enable = true;

    # ---------- Programs ---------- #

    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
    chromium = {
      enable = true;
      extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [ "de" "en-US" ];
    };
    };
    firefox = {
      enable = true;
    };

    # ---------- Games ---------- #

    steam.dedicatedServer.openFirewall = true;
    steam.enable = true;
    steam.remotePlay.openFirewall = true;
  };
}
