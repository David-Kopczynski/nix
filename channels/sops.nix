{ ... }:

{
  imports = [ <sops-nix/modules/sops> ];

  sops.defaultSopsFile = ../resources/sops/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = /home/${"user"}/.config/sops/age/keys.txt;
}
