{ unstable }:
{ config, ... }:

let
  modules = [ ];
  packages = [ "r2modman" ];
in
{
  disabledModules = modules;
  imports = map (n: "${unstable}/nixos/modules/${n}") modules;

  nixpkgs.overlays =
    let
      unstable-pkgs = import unstable { config = config.nixpkgs.config; };
    in
    map (n: (final: prev: { ${n} = unstable-pkgs.${n}; })) packages;
}
