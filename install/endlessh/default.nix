{ ... }:

{
  services.endlessh.enable = true;
  services.endlessh = {

    # General
    port = 22;
    openFirewall = true;
  };

  # Move sshd port
  services.openssh.ports = [ 2244 ];
}
