{ user }:

{
  home-manager.users.${user} = { lib, ... }: {

    dconf.settings =
      let
        folder = [
          ({ name = "Audio & Video"; } // { categories = [ "Audio" ] ++ [ "Video" ]; })
          ({ name = "Browsing"; } // { categories = [ "Network" ]; })
          ({ name = "Design"; } // { categories = [ "Graphics" ]; })
          ({ name = "Development"; } // { categories = [ "Development" ] ++ [ "Engineering" ]; })
          ({ name = "Games"; } // { categories = [ "Game" ]; })
          ({ name = "GNOME"; } // { categories = [ "GNOME" ]; })
          ({ name = "Office"; } // { categories = [ "Office" ]; })
          ({ name = "Social"; } // { categories = [ "Chat" ]; })
          ({ name = "Utility"; } // { categories = [ "Utility" ] ++ [ "ConsoleOnly" ]; })
          ({ name = "System"; } // { categories = [ "System" ] ++ [ "Monitor" ]; })
          ({ name = "Settings"; } // { categories = [ "Settings" ]; })
        ];
      in
      {
        # Sort apps alphabetically
        "org/gnome/shell".app-picker-layout = [ ];

        # Display applications by category
        "org/gnome/desktop/app-folders".folder-children = map (n: lib.escapeShellArg n.name) folder;
      }
      // lib.mergeAttrsList (
        map (n: { "org/gnome/desktop/app-folders/folders/${lib.escapeShellArg n.name}" = n; }) folder
      );
  };
}
