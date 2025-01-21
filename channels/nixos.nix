{ ... }:

{
  # Allow unfree applications
  nixpkgs.config.allowUnfree = true;
  home-manager.users."user".xdg.configFile."nixpkgs/config.nix".text = ''{ allowUnfree = true; }'';
}
