{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  environment.systemPackages = with pkgs; [ gnome-remote-desktop ];
  services.gnome.gnome-remote-desktop.enable = true;

  services.xrdp.enable = true;
  services.xrdp.audio.enable = true;
  services.xrdp.defaultWindowManager = "${with pkgs; gnome-session}/bin/gnome-session";
  services.xrdp.extraConfDirCommands = ''
    substituteInPlace $out/xrdp.ini \
      --replace "security_layer=negotiate" "security_layer=rdp" \
      --replace "crypt_level=high" "crypt_level=none"
  '';

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
