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
    { config, ... }:
    {
      # Writable config directory
      xdg.configFile."hyperhdr.db" = {

        # Copy config into place to prevent read-only errors
        onChange =
          let
            dir = config.xdg.configHome;
          in
          ''
            rm -f ${dir}/hyperhdr/db/hyperhdr.db
            cp -L ${dir}/hyperhdr.db ${dir}/hyperhdr/db/hyperhdr.db
            chmod +w ${dir}/hyperhdr/db/hyperhdr.db
          '';

        source = ./hyperhdr.db;
      };

      # Custom keybindings
      dconf.settings =
        let
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

  # Allow serial port access
  users.users."user".extraGroups = [ "dialout" ];
}
