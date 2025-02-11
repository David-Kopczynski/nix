{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  environment.systemPackages = with pkgs; [ hyperion-ng ];

  systemd.services.hyperiond = {

    description = "Hyperion.ng Service";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      User = "user";
      ExecStart = "${with pkgs; hyperion-ng}/bin/hyperiond --service";
      TimeoutStopSec = "10";
      Restart = "on-failure";
    };
  };
}
