{ ... }:

{
  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = [ "discord" ] ++ [ "discord-unwrapped" ];
}
