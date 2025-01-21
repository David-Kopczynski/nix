{ config, pkgs, ... }:

{
  # see https://www.programmingfonts.org for more examples
  fonts.packages = with pkgs; [
    fira-code
    monocraft
  ];

  # Default fonts for special purposes
  fonts.fontconfig.defaultFonts = {

    # other values are: serif sansSerif emoji
    monospace = [
      "FiraCode"
      "Monocraft"
    ];
  };

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/interface" = {

      # other values are: font-name document-font-name
      monospace-font-name = "Monocraft 8";
    };
  };
}
