{ lib, ... }:

{
  imports =
    [
      ./env.nix # Envorinment variables
      ./secrets.nix # Secrets
    ]

    ++ builtins.concatMap (dir: builtins.map (n: toString dir + "/${n}") (builtins.attrNames (builtins.readDir dir)))
      [
        # Automatically include all configuration from:
        ./channels
        ./hosts/default
        ./install
      ];
}
