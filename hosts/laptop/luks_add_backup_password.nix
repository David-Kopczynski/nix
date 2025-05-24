with import <nixpkgs> { };

let
  pbkdf2-sha512 = pkgs.callPackage "${
    pkgs.fetchFromGitHub {
      owner = "sgillespie";
      repo = "nixos-yubikey-luks";
      rev = "master";
      sha256 = "sha256-qmvBrvSo30kW+meehETdgjvxCmrWrc5cBBGdViJ39gU=";
    }
  }/pbkdf2-sha512" { };
in
mkShell { packages = [ openssl ] ++ [ pbkdf2-sha512 ] ++ [ yubikey-personalization ]; }
