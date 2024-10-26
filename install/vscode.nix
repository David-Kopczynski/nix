{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ vscode ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-text-editor ];
}
