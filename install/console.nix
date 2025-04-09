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

  # Main application
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/shell" = {
      favorite-apps = [ "org.gnome.Console.desktop" ];
    };
  };
}
