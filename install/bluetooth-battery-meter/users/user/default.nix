{ user }:

{
  home-manager.users.${user} =
    { pkgs, ... }:
    let
      extensions = with pkgs; [ gnomeExtensions.bluetooth-battery-meter ];
    in
    {
      home.packages = extensions;
      dconf.settings = {

        # Enable extension
        "org/gnome/shell".enabled-extensions = map (n: n.extensionUuid) extensions;

        # Custom settings
        "org/gnome/shell/extensions/Bluetooth-Battery-Meter" = {

          # Theming
          level-indicator-color = 0;
          circle-widget-color = 0;
        };
      };
    };
}
