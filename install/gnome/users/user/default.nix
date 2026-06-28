{ user }:
{ lib, ... }:

{
  imports =
    # Source configuration from ./*
    lib.pipe (builtins.readDir ./.) [
      (lib.filterAttrs (n: m: m == "directory"))
      (x: map (n: lib.filesystem.resolveDefaultNix ./${n}) (builtins.attrNames x))
      (map (n: import n { inherit user; }))
    ];
}
