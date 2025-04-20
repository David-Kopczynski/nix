{ config, pkgs, ... }:

let
  patched-openssh = pkgs.openssh.overrideAttrs (prev: {
    patches = (prev.patches or [ ]) ++ [ ../resources/vscode/patched-openssh.patch ];
    doCheck = false;
  });
in
{
  home-manager.users."user".programs.vscode.enable = true;
  home-manager.users."user".programs.vscode.package = pkgs.unstable.vscode.fhsWithPackages (
    _:
    [ patched-openssh ]
    ++ (with pkgs; [
      # Packages required by various profiles
      nixd
      nixfmt-rfc-style
      texliveFull
    ])
  );

  # Main application
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/shell" = {
      favorite-apps = [ "code.desktop" ];
    };
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-text-editor ];
}
