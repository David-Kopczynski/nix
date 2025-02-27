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

  # Prevent fullscreen pipewire issues
  environment.systemPackages = with pkgs; [ gnomeExtensions.disable-unredirect-fullscreen-windows ];

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Prevent screen lock
    settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [
        gnomeExtensions.disable-unredirect-fullscreen-windows.extensionUuid
      ];
    };
  };

  users.users."user".extraGroups = [ "dialout" ];
}
