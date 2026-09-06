{ ... }:

{
  home-manager.users."user" =
    { pkgs, ... }:
    let
      extensions = with pkgs; [ gnomeExtensions.quick-settings-audio-devices-hider ];
    in
    {
      home.packages = extensions;
      dconf.settings = {

        # Enable extension
        "org/gnome/shell".enabled-extensions = map (n: n.extensionUuid) extensions;

        # Configure sinks
        "org/gnome/shell/extensions/quicksettings-audio-devices-hider".excluded-output-names = [
          "HDMI / DisplayPort – TU104 HD Audio Controller" # Secondary Monitor
          "HDMI / DisplayPort 3 – TU104 HD Audio Controller" # Tertiary Monitor
          "Digital Output (S/PDIF) – CORSAIR VIRTUOSO SE Wireless Gaming Headset" # Bad Headset Sink
        ];
      };
    };
}
