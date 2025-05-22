{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [ libreoffice ] ++ [ hunspell ] ++ [ hunspellDicts.en_US ] ++ [ hunspellDicts.de_DE ];

  # Interface folder
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/app-folders" = {
      folder-children = [ "libre" ];
    };

    settings."org/gnome/desktop/app-folders/folders/libre" = {
      name = "LibreOffice";
      apps = [
        "startcenter.desktop"
        "base.desktop"
        "calc.desktop"
        "draw.desktop"
        "impress.desktop"
        "math.desktop"
        "writer.desktop"
      ];
    };
  };
}
