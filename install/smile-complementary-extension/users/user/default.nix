{ user }:

{
  home-manager.users.${user} =
    { lib, pkgs, ... }:
    let
      extensions = with pkgs; [ gnomeExtensions.smile-complementary-extension ];
    in
    {
      home.packages = extensions ++ (with pkgs; [ smile ]);
      dconf.settings = {

        # Enable extension
        "org/gnome/shell".enabled-extensions = map (n: n.extensionUuid) extensions;

        # Custom settings
        "it/mijorus/smile" = {

          # General
          is-first-run = false;
        };
      }
      // (
        let
          # Custom keybindings
          target = "org/gnome/settings-daemon/plugins/media-keys";
          keybindings = [
            {
              name = "Open Smile";
              command = "smile";
              binding = "<Shift><Control>comma";
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
