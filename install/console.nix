{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh = {

    # General configuration
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # Theming
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  users.defaultUserShell = with pkgs; zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.bash.interactiveShellInit = ''if [ -n "$IN_NIX_SHELL" ]; then exec "${with pkgs; zsh}/bin/zsh"; fi'';

  # Main application
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/shell" = {
      favorite-apps = [ "org.gnome.Console.desktop" ];
    };
  };

  # Remove default application
  services.xserver.excludePackages = with pkgs; [ xterm ];
}
