{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.host == "workstation") {
  environment.systemPackages = with pkgs; [ hyperion-ng ];

  systemd.services.hyperiond = {
    enable = true;

    description = "Hyperion.ng Service";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      User = "user";
      ExecStart = "${pkgs.hyperion-ng}/bin/hyperiond --service";
      TimeoutStopSec = "10";
      Restart = "on-failure";
    };
  };
}
