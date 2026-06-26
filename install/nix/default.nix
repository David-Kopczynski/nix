{ ... }:

{
  nix.gc.automatic = true;
  nix.gc = {

    # General
    options = "--delete-older-than 14d";
  };
}
