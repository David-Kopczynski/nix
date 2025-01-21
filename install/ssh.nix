{ config, ... }:

{
  # OpenSSH server configuration
  services.openssh.enable = true;
  services.openssh = {

    # Allow only my public keys
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    authorizedKeysFiles = [ "${config.root}/resources/ssh/authorized_keys" ];
  };

  home-manager.users."user".programs.ssh = {
    inherit (config.services.openssh) enable;

    matchBlocks = {
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      #               Reverse Proxy for SSH               #
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      "proxmox" = {
        hostname = "10.1.0.0";
        proxyJump = "nixos-server";
        user = "root";
      };
      "nixos-server" = {
        hostname = "ssh.davidkopczynski.com";
        user = "root";
      };
      "backup-server" = {
        hostname = "10.0.1.20";
        proxyJump = "nixos-server";
        user = "root";
      };
      "workstation" = {
        hostname = "192.168.0.123";
        proxyJump = "nixos-server";
        user = "user";
      };

      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      #                   PSP Websites                    #
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      "psp-website" = {
        hostname = "psp-website.embedded.rwth-aachen.de";
        user = "psp";
      };
      "psp-website-dev" = {
        hostname = "psp-website-dev.embedded.rwth-aachen.de";
        user = "psp";
      };
    };

    userKnownHostsFile = "~/.ssh/known_hosts ${config.root}/resources/ssh/known_hosts";
  };
}
