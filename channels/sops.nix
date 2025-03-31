{ ... }:

{
  imports = [ <sops-nix/modules/sops> ];

  sops.defaultSopsFile = ../resources/sops/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.generateKey = true;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
}
