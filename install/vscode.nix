{ config, pkgs, ... }:

let
  patched-openssh = pkgs.openssh.overrideAttrs (prev: {
    patches = (prev.patches or [ ]) ++ [ ../resources/vscode/patched-openssh.patch ];
    doCheck = false;
  });
in
{
  home-manager.users.user.programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: config.environment.systemPackages ++ [ patched-openssh ]
    );
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-text-editor ];
}
