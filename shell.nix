{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {

  # Required packages
  nativeBuildInputs = with pkgs; [
    nixd
    nixfmt
  ];

  shellHook = "unset TEMP TMP TEMPDIR TMPDIR";
}
