{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnome; [ gnome-remote-desktop ];
  services.gnome.gnome-remote-desktop.enable = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${pkgs.gnome.gnome-session}/bin/gnome-session";
  services.xrdp.openFirewall = true;
}
