{ config, pkgs, ... }:

let
  patched-openssh = pkgs.openssh.overrideAttrs (prev: {
    patches = (prev.patches or [ ]) ++ [ ../resources/vscode/patched-openssh.patch ];
    doCheck = false;
  });
in
{
  home-manager.users."user".programs.vscode.enable = true;
  home-manager.users."user".programs.vscode.package =
    with pkgs.unstable;
    vscode.fhsWithPackages (
      ps:
      [ patched-openssh ]
      ++ [
        # Packages required by various profiles
        nixd
        nixfmt-rfc-style
        python3
        texliveFull
      ]
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
