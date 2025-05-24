{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ celluloid ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ decibels ] ++ [ gnome-music ] ++ [ totem ];
}
