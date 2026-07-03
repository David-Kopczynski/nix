{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd.user.services."hyperhdr" = {

    description = "HyperHDR Ambient Light Systemd Service";

    after = [ "graphical-session.target" ];
    bindsTo = [ "graphical-session.target" ];

    serviceConfig = {

      ExecStart = lib.getExe (
        pkgs.writeShellApplication {

          name = "hyperhdr-wrapper";
          runtimeInputs = with pkgs; [ hyperhdr ];
          text = ''
            exec hyperhdr --pipewire --userdata ${config.home-manager.users."user".xdg.configHome}/hyperhdr
          '';
        }
      );

      KillMode = "mixed";
      TimeoutStopSec = "5s";
    };
  };

  # Prevent fullscreen pipewire issues
  environment.systemPackages = with pkgs; [ gnomeExtensions.disable-unredirect ];
}
