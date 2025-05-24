{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ btop ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ baobab ] ++ [ gnome-system-monitor ];
}
