{ user }:

{
  home-manager.users.${user} = { lib, ... }: {

    dconf.settings = {

      # Show application in quick launcher
      "org/gnome/shell".favorite-apps = [ "org.gnome.Console.desktop" ];
    }
    // (
      let
        # Custom keybindings
        target = "org/gnome/settings-daemon/plugins/media-keys";
        keybindings = [
          {
            name = "Open Terminal";
            command = "kgx";
            binding = "<Control><Alt>t";
          }
        ];
      in
      {
        "${target}".custom-keybindings = map (
          n: "/${target}/custom-keybindings/custom-${lib.escapeShellArg n.name}/"
        ) keybindings;
      }
      // lib.mergeAttrsList (
        map (n: {
          "${target}/custom-keybindings/custom-${lib.escapeShellArg n.name}" = n;
        }) keybindings
      )
    );
  };
}
