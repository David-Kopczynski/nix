{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [ gnomeExtensions.executor ];

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [ gnomeExtensions.executor.extensionUuid ];
    };

    # Custom settings
    settings."org/gnome/shell/extensions/executor" = {

      center-active = false;
      center-commands-json = with lib.gvariant; [
        (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ])
      ];

      left-active = false;
      left-commands-json = with lib.gvariant; [
        (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ])
      ];

      right-active = false;
      right-commands-json = with lib.gvariant; [
        (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ])
      ];

      click-on-output-active = false;
    };
  };
}
