{ config, pkgs, ... }:

{
  home-manager.users.user.programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; config.environment.systemPackages);
  };

  # Fix SSH config permissions for FHS
  home-manager.users.user.home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-text-editor ];
}
