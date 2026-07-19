{ ... }:

{
  programs.nh.enable = true;
  programs.nh = {

    # General
    clean.enable = true;
    clean.extraArgs = "--keep 8 --keep-since 14d";
  };

  # Experimental dependency
  nix.settings.experimental-features = [ "nix-command" ];
}
