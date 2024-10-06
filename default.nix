{ lib, ... }:

{
  imports = [

    # Envorinment variables
    ./env.nix

    # Default system configuration
    ./hosts/default
    ./hosts
  ]

  # Automatically include all channel configs from ./channels
  ++ builtins.map (n: toString ./channels + "/${n}") (builtins.filter (lib.strings.hasSuffix ".nix") (builtins.attrNames (builtins.readDir ./channels)))

  # Automatically include all install configs from ./install
  ++ builtins.map (n: toString ./install + "/${n}") (builtins.filter (lib.strings.hasSuffix ".nix") (builtins.attrNames (builtins.readDir ./install)));
}
