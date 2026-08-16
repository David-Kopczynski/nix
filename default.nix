{ config, lib, ... }:

{
  assertions = [
    {
      assertion = lib.versionAtLeast config.system.nixos.release config.system.stateVersion;
      message = "Current NixOS version is older than configured state version.";
    }
  ];

  # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #                   System Setup                    #
  # # # # # # # # # # # # # # # # # # # # # # # # # # #
  imports =
    # General dependencies
    [
      "${(import ./npins).home-manager}/nixos"
      "${(import ./npins).sops-nix}/modules/sops"
    ]
    # Source basic system configuration from ./install/*
    ++ lib.pipe (builtins.readDir ./install) [
      (x: map (n: lib.filesystem.resolveDefaultNix ./install/${n}) (builtins.attrNames x))
      (builtins.filter builtins.pathExists)
    ]
    # Source unstable overrides from ./install/*/unstable.nix
    ++ lib.pipe (builtins.readDir ./install) [
      (x: map (n: ./install/${n}/unstable.nix) (builtins.attrNames x))
      (builtins.filter builtins.pathExists)
      (map (n: import n { unstable = (import ./npins).nixos-unstable; }))
    ]
    # Source user configuration from ./install/*/users
    ++ lib.pipe (builtins.readDir ./install) [
      (x: map (n: ./install/${n}/users) (builtins.attrNames x))
      (builtins.filter builtins.pathExists)
      (builtins.concatMap (n: map (m: n + /${m}) (builtins.attrNames (builtins.readDir n))))
      (map (n: import n { user = lib.removeSuffix ".nix" (baseNameOf n); }))
    ];

  # Declarative channels
  nix.channel.enable = false;
  nix.nixPath = lib.toList "nixpkgs=${(import ./npins).nixpkgs}";

  # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #                   Home Manager                    #
  # # # # # # # # # # # # # # # # # # # # # # # # # # #
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #                     sops-nix                      #
  # # # # # # # # # # # # # # # # # # # # # # # # # # #
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.gnupg.sshKeyPaths = [ ];
}
