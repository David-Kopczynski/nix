{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # General configuration
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Theming
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
  };

  # Enable ZSH as default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
}
