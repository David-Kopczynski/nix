{ pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh = {

    # General configuration
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # Disable first-use wizard
    shellInit = "zsh-newuser-install() { :; }";

    # Theming
    ohMyZsh.enable = true;
    ohMyZsh.theme = "robbyrussell";
  };

  users.defaultUserShell = with pkgs; zsh;
  environment.shells = with pkgs; [ zsh ];
}
