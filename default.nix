{ ... }:

{
  # Automatically install all configuration from channel and install directory
  imports = builtins.concatMap (
    dir: builtins.map (n: toString dir + "/${n}") (builtins.attrNames (builtins.readDir dir))
  ) ([ ./channels ] ++ [ ./install ]);
}
