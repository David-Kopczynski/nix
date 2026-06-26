{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ nav ];

  # Shell hook for additional features
  environment.interactiveShellInit = ''eval "$(nav --init "$(basename "$SHELL")")"'';
}
