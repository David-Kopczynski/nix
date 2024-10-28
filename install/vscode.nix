{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ vscode.fhs ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-text-editor ];
}
