{ user }:

{
  home-manager.users.${user} = { pkgs, ... }: {

    home.packages = with pkgs; [ fira-code ] ++ [ monocraft ];

    # Default fonts
    fonts.fontconfig.defaultFonts.monospace = [ "FiraCode" ] ++ [ "Monocraft" ];
    dconf.settings."org/gnome/desktop/interface".monospace-font-name = "Monocraft 8";
  };
}
