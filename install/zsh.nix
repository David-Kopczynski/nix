{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh = {

    # General configuration
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Theming
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "robbyrussell";
  };

  # Enable ZSH as default shell
  users.defaultUserShell = with pkgs; zsh;
  environment.shells = with pkgs; [ zsh ];

  # Shell helpers
  programs.thefuck.enable = true;

  environment.systemPackages = with pkgs; [ nav ];
  programs.bash.shellInit = "eval \"$(nav --init bash)\"";
  programs.zsh.shellInit = "eval \"$(nav --init zsh)\"";

  # Main application
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/shell" = {
      favorite-apps = [ "org.gnome.Console.desktop" ];
    };
  };
}
