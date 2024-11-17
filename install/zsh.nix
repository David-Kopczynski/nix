{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

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
}
