{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ nav ];

  environment.interactiveShellInit = ''eval "$(nav --init "$(basename "$SHELL")")"'';
}
