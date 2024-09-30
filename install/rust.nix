{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ rustc cargo gcc rustfmt clippy ];

  environment.variables = {

    # Rust tool setup with NixOS
    # See: https://nixos.wiki/wiki/Rust
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}
