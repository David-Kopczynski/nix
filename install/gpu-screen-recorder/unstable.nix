{ unstable }:
{ config, ... }:

let
  modules = [ "programs/gpu-screen-recorder.nix" ];
  packages = [
    "gpu-screen-recorder"
    "gpu-screen-recorder-ui"
    "gpu-screen-recorder-notification"
  ];
in
{
  disabledModules = modules;
  imports = map (n: unstable + /nixos/modules/${n}) modules;

  nixpkgs.overlays =
    let
      unstable-pkgs = import unstable { config = config.nixpkgs.config; };
    in
    map (n: (final: prev: { ${n} = unstable-pkgs.${n}; })) packages;
}
