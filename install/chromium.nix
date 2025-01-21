{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ chromium ];

  programs.chromium.enable = true;
  programs.chromium.extraOpts = {

    # General configuration
    "BrowserSignin" = 0;
    "SyncDisabled" = true;
    "PasswordManagerEnabled" = false;
    "SpellcheckEnabled" = true;
    "SpellcheckLanguage" = [
      "de"
      "en-US"
    ];
  };
}
