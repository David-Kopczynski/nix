{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [ monocraft ];

  # Default fonts for special purposes
  fonts.fontconfig.defaultFonts = {

    # other values are: serif sansSerif emoji
    monospace = [ "Monocraft" ];
  };

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/interface" = {

      # other values are: font-name document-font-name
      monospace-font-name = "Monocraft";
    };
  };
}
