{ config, ... }:

{
  services.openssh.enable = true;

  home-manager.users.user.programs.ssh = {
    inherit (config.services.openssh) enable;

    matchBlocks = {
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      #         Cloudflared Reverse Proxy for SSH         #
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      "proxy" = {
        hostname = "ssh.davidkopczynski.com";
        user = "root";
      };
      "proxmox" = {
        hostname = "10.1.0.0";
        proxyJump = "proxy";
        user = "root";
        localForwards = [
          {
            bind.port = 8006;
            host.address = "localhost";
            host.port = 8006;
          }
        ];
      };
      "kuma" = {
        hostname = "10.0.1.10";
        proxyJump = "proxy";
        user = "root";
      };
      "base" = {
        hostname = "10.0.2.10";
        proxyJump = "proxy";
        user = "root";
      };
      "pihole" = {
        hostname = "10.0.3.10";
        proxyJump = "proxy";
        user = "root";
      };
      "printer" = {
        hostname = "10.0.3.20";
        proxyJump = "proxy";
        user = "root";
      };
      "home" = {
        hostname = "10.0.3.30";
        proxyJump = "proxy";
        user = "root";
      };
      "cloud" = {
        hostname = "10.0.4.10";
        proxyJump = "proxy";
        user = "root";
      };
      "archive" = {
        hostname = "10.0.4.20";
        proxyJump = "proxy";
        user = "root";
      };
      "photos" = {
        hostname = "10.0.4.30";
        proxyJump = "proxy";
        user = "root";
      };
      "pdf" = {
        hostname = "10.0.4.40";
        proxyJump = "proxy";
        user = "root";
      };
      "bachelor" = {
        hostname = "10.0.5.10";
        proxyJump = "proxy";
        user = "root";
      };
      "test" = {
        hostname = "10.0.9.00";
        proxyJump = "proxy";
        user = "root";
      };
      "backup-server" = {
        hostname = "10.0.1.20";
        proxyJump = "proxy";
        user = "root";
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
