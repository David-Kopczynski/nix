{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ mpv ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ decibels ] ++ [ gnome-music ] ++ [ totem ];
}
