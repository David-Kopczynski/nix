{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ remmina ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome-connections ];
}
