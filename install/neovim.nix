{ ... }:

{
  programs.neovim.enable = true;

  # Additional basic configuration options
  programs.neovim = {
    vimAlias = true;
    viAlias = true;

    defaultEditor = false;
  };
}
