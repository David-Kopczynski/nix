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
    Exec=${with pkgs; hyperhdr}/bin/hyperhdr --service --pipewire --userdata ${../resources/hyperhdr}
    X-GNOME-Autostart-enabled=true
    OnlyShowIn=GNOME;
  '';

  # Prevent screen lock
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;
  };

  users.users."user".extraGroups = [ "dialout" ];
}
