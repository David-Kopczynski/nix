{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    cmake
    gnumake
    clang-tools
    ccls
    gdb
  ];
}
