{ user }:

{
  home-manager.users.${user} =
    { lib, pkgs, ... }:
    let
      extensions = with pkgs; [ gnomeExtensions.brightness-control-using-ddcutil ];
    in
    {
      home.packages = extensions;
      dconf.settings = {

        # Enable extension
        "org/gnome/shell".enabled-extensions = map (n: n.extensionUuid) extensions;

        # Custom settings
        "org/gnome/shell/extensions/display-brightness-ddcutil" = {

          # General
          ddcutil-binary-path = lib.getExe (with pkgs; ddcutil);
          allow-zero-brightness = true;

          # Theming
          button-location = 1;
          hide-system-indicator = true;
        };
      };
    };

  # Allow access to I2C peripherals
  users.users.${user}.extraGroups = [ "i2c" ];
}
