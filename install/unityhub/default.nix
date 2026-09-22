{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ unityhub ];

  # Allow unfree application
  nixpkgs.config.allowUnfreePackages = [ "unityhub" ] ++ [ "corefonts" ];
}
