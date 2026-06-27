{ user }:

{
  home-manager.users.${user} = { config, ... }: {

    assertions = [
      {
        assertion =
          let
            proxmox = fetchTarball "https://github.com/David-Kopczynski/proxmox/archive/master.tar.gz";
            vms = builtins.attrNames (builtins.readDir "${proxmox}/install");
            hosts = builtins.attrNames config.programs.ssh.settings;
          in
          builtins.all (x: builtins.elem x hosts) vms;
        message = "VMs are missing from Proxmox setup for SSH.";
      }
    ];

    programs.ssh.enable = true;
    programs.ssh = {

      # General
      enableDefaultConfig = false;

      # Known servers
      settings."nginx" = {
        port = 2244;
        user = "root";
        hostname = "ssh.davidkopczynski.com";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZz3LhKcZ7JO0svukrUqPoPr7qt8h1KcRR4OGt/8LiP'";
        strictHostKeyChecking = "yes";
      };
      settings."adguardhome" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh5/fme7y7FgJbblviXAjskkw4vDKrM6DzkW41gADGT'";
        strictHostKeyChecking = "yes";
      };
      settings."backup-server" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0Oczr0l8wwIgl8I1MDRFpg5axqOILQBtRbKeYcj7g/'";
        strictHostKeyChecking = "yes";
      };
      settings."immich" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaFuVx62iHZZiIaS4yrxB9ESAM9b18MAgpE1BZc5U82'";
        strictHostKeyChecking = "yes";
      };
      settings."mealie" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGra11agGDCPJL7E4xhC/DNP9IihxTobIHn52BFYk5d2'";
        strictHostKeyChecking = "yes";
      };
      settings."minecraft" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF1jH8/fmzoV1ApfckrkyWWRUo/tKiMnnoxk7jEcfYsl'";
        strictHostKeyChecking = "yes";
      };
      settings."nextcloud" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGW9QriBYWifeMjTLd24S2ZyLEzMx2pIxh80rS2z/XvA'";
        strictHostKeyChecking = "yes";
      };
      settings."octoprint" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKa6BE5+WLQpY8DBokdTdlCEuCRvksQM5Uw6aW0tJY45'";
        strictHostKeyChecking = "yes";
      };
      settings."paperless" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcUrveZXqiXnlPDD5ToWy2uXbwirzTLIW1o7dT5DlzP'";
        strictHostKeyChecking = "yes";
      };
      settings."proxmox" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEnQssJHJPe+Nea80W7j9jAYwBoa6rbbpkLmAVN+tIm'";
        strictHostKeyChecking = "yes";
      };
      settings."stirling-pdf" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID6Y5ST4k4+dJvQZP2KIEbKJgKd0WgUMJ2bF0MajCqy3'";
        strictHostKeyChecking = "yes";
      };
      settings."uptime-kuma" = {
        user = "root";
        proxyJump = "nginx";
        knownHostsCommand = "/usr/bin/env printf '%H ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGpt8nyXM2NN3MxxhwhPDPGJdND1YGnc6r8q0d+CaaS'";
        strictHostKeyChecking = "yes";
      };
    };
  };
}
