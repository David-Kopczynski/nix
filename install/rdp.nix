{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.host == "workstation") {
  environment.systemPackages = with pkgs; [ gnome.gnome-remote-desktop ];
  services.gnome.gnome-remote-desktop.enable = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${pkgs.gnome.gnome-session}/bin/gnome-session";
  services.xrdp.openFirewall = true;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
