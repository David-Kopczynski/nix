{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd.user.services."hyperhdr" = {

    # Unit
    description = "HyperHDR Ambient Light Systemd Service";
    after = [ "network.target" ];

    # Install
    wantedBy = [ "default.target" ] ++ [ "multi-user.target" ];

    serviceConfig = {

      # Service
      ExecStart = "${lib.getExe (with pkgs; hyperhdr)} --pipewire --userdata ${
        config.home-manager.users."user".xdg.configHome
      }/hyperhdr";

      User = "user";
      TimeoutStopSec = "5";
      KillMode = "mixed";
      Restart = "on-failure";
      RestartSec = "2";
    };
  };

  home-manager.users."user" =
    { ... }:
    {
      dconf.settings =
        let
          # Custom keybindings
          target = "org/gnome/settings-daemon/plugins/media-keys";
          keybindings = [
            {
              name = "Restart HyperHDR";
              command = "systemctl --user restart hyperhdr.service";
              binding = "<Control><Alt>numbersign";
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
        );
    };

  # Configuration
  systemd.tmpfiles.rules = [
    "L+ ${
      config.home-manager.users."user".xdg.configHome
    }/hyperhdr/db/hyperhdr.db - - - - ${./hyperhdr.db}"
  ];

  # Allow serial port access
  users.users."user".extraGroups = [ "dialout" ];
}
