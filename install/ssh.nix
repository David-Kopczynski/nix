{ config, ... }:

{
  # OpenSSH server configuration
  services.openssh.enable = true;
  services.openssh = {

    # Allow only my public keys
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    authorizedKeysFiles = [ (toString ../resources/ssh/authorized_keys) ];
  };

  home-manager.users."user".programs.ssh = {
    inherit (config.services.openssh) enable;

    matchBlocks = {
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      #               Reverse Proxy for SSH               #
      # # # # # # # # # # # # # # # # # # # # # # # # # # #
      "backup-server" = {
        hostname = "192.168.0.170";
        proxyJump = "nginx";
        user = "root";
      };
      "home-assistant" = {
        hostname = "home-assistant";
        proxyJump = "nginx";
        user = "root";
      };
      "immich" = {
        hostname = "immich";
        proxyJump = "nginx";
        user = "root";
      };
      "nextcloud" = {
        hostname = "nextcloud";
        proxyJump = "nginx";
        user = "root";
      };
      "nginx" = {
        hostname = "ssh.davidkopczynski.com";
        user = "root";
      };
      "octoprint" = {
        hostname = "octoprint";
        proxyJump = "nginx";
        user = "root";
      };
      "paperless" = {
        hostname = "paperless";
        proxyJump = "nginx";
        user = "root";
      };
      "proxmox" = {
        hostname = "192.168.0.169";
        proxyJump = "nginx";
        user = "root";
      };
      "stirling-pdf" = {
        hostname = "stirling-pdf";
        proxyJump = "nginx";
        user = "root";
      };
      "uptime-kuma" = {
        hostname = "uptime-kuma";
        proxyJump = "nginx";
        user = "root";
      };
      "workstation" = {
        hostname = "192.168.0.20";
        proxyJump = "nginx";
        user = "user";
      };
    };

    userKnownHostsFile = "~/.ssh/known_hosts ${../resources/ssh/known_hosts}";
  };

  # Security
  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
}
