{ user }:

{
  home-manager.users.${user} =
    { pkgs, ... }:
    let
      extensions = with pkgs; [ gnomeExtensions.color-picker ];
    in
    {
      home.packages = extensions;
      dconf.settings = {

        # Enable extension
        "org/gnome/shell".enabled-extensions = map (n: n.extensionUuid) extensions;
      };
    };
}
