{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ccls
    clang-tools
    cmake
    gcc
    gdb
    gnumake
  ];
}
