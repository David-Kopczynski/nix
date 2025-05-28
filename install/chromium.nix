{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ chromium ];

  programs.chromium.enable = true;
  programs.chromium.extraOpts = {

    # General configuration
    "BrowserSignin" = false;
    "DefaultBrowserSettingEnabled" = false;
    "PasswordManagerEnabled" = false;
    "SpellcheckEnabled" = true;
    "SpellcheckLanguage" = [ "de" ] ++ [ "en-US" ];
    "SyncDisabled" = true;
  };
}
