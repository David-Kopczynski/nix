{
  config,
  lib,
  pkgs,
  ...
}:

let
  rdp-desktop = pkgs.writeShellApplication {

    name = "rdp-desktop";
    runtimeInputs = with pkgs; [ freerdp3 ];
    text = ''
      # Forward RDP over SSH
      ssh workstation -L 3389:localhost:3389 -fNT
      SSH_PID=$(pgrep -n -x ssh)

      clean() {
        kill "$SSH_PID"
      }

      trap clean EXIT

      # Connect to forwarded server
      xfreerdp /v:localhost \
        /u:user /p:"$(cat ${config.sops.secrets."rdp/password".path})" \
        /smart-sizing /size:1920x1280 +f \
        /microphone /sound \
        /kbd:layout:german +clipboard \
        /t:RDP-Desktop
    '';
  };
in
lib.mkIf (config.system.name == "laptop") {
  environment.systemPackages = [ rdp-desktop ];

  # Secrets for RDP
  sops.secrets."rdp/password" = {
    owner = config.users.users."user".name;
  };
}
