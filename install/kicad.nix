{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ kicad-small ];

  # Interface folder
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/app-folders" = {
      folder-children = [ "kicad" ];
    };

    settings."org/gnome/desktop/app-folders/folders/kicad" = {
      name = "KiCad";
      apps = [
        "org.kicad.kicad.desktop"
        "org.kicad.gerbview.desktop"
        "org.kicad.bitmap2component.desktop"
        "org.kicad.pcbcalculator.desktop"
        "org.kicad.pcbnew.desktop"
        "org.kicad.eeschema.desktop"
      ];
    };
  };
}
