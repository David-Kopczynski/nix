{ lib, ... }:

{
  imports =
    [
      ./env.nix # Envorinment variables
    ]

    # Automatically include default system configuration from ./hosts/default
    ++ builtins.map (n: toString ./hosts/default + "/${n}") (builtins.filter (lib.strings.hasSuffix ".nix") (builtins.attrNames (builtins.readDir ./hosts/default)))

    # Automatically include all channel configs from ./channels
    ++ builtins.map (n: toString ./channels + "/${n}") (builtins.filter (lib.strings.hasSuffix ".nix") (builtins.attrNames (builtins.readDir ./channels)))

    # Automatically include all install configs from ./install
    ++ builtins.map (n: toString ./install + "/${n}") (builtins.filter (lib.strings.hasSuffix ".nix") (builtins.attrNames (builtins.readDir ./install)));
}
