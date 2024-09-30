{ ... }:

{
  # Import all used NixOS modules
  imports = [
    ./locale.nix
    ./network.nix
    ./sound.nix
    ./system.nix
    ./users.nix
    ./window.nix
  ];
}
