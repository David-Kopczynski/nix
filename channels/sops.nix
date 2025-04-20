{ config, pkgs, ... }:

{
  imports = [ <sops-nix/modules/sops> ];

  sops.defaultSopsFile = ../resources/sops/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.sshKeyPaths = [ "${config.home-manager.users."user".home.homeDirectory}/.ssh/id_ed25519" ];
  sops.gnupg.sshKeyPaths = [ ];

  # Generate age keys with correct owner and permissions
  # Required to edit secrets via `sops` command
  home-manager.users."user" =
    { lib, ... }:
    {
      home.activation."ssh-to-age" = lib.hm.dag.entryAfter [ "sshActivatioinAction" ] ''
        AGE_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/sops/age"

        mkdir -p $AGE_HOME
        : > $AGE_HOME/keys.txt

        for sshKey in ${builtins.concatStringsSep " " config.sops.age.sshKeyPaths}; do
          ${with pkgs; ssh-to-age}/bin/ssh-to-age -private-key -i $sshKey >> "$AGE_HOME/keys.txt"
        done
      '';
    };
}
