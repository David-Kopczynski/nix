{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  home-manager.users."user".xdg.configFile."autostart/hyperhdr.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=HyperHDR
    Exec=${with pkgs; hyperhdr}/bin/hyperhdr --service --pipewire --userdata ${toString ../resources/hyperhdr}
    X-GNOME-Autostart-enabled=true
  '';

  users.users."user".extraGroups = [ "dialout" ];
}
