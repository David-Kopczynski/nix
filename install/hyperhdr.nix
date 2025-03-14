{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  home-manager.users."user".xdg.configFile."autostart/hyperhdr.desktop".text =
    let
      dir = config.home-manager.users."user".xdg.configHome;
    in
    # Check if running via RDP etc. by checking for :10 in DISPLAY
    ''
      [Desktop Entry]
      Type=Application
      Name=HyperHDR
      Exec=sh -c '[ "''${DISPLAY#:10}" == "$DISPLAY" ] && exec ${with pkgs; hyperhdr}/bin/hyperhdr --service --pipewire --userdata ${dir}/hyperhdr'
      X-GNOME-Autostart-enabled=true
      OnlyShowIn=GNOME;
    '';

  # Writable config directory
  home-manager.users."user".xdg.configFile."_hyperhdr" = {

    # Copy config into place to prevent read-only errors
    onChange =
      let
        dir = config.home-manager.users."user".xdg.configHome;
      in
      ''
        rm -rf ${dir}/hyperhdr
        cp -rL ${dir}/_hyperhdr ${dir}/hyperhdr
        chmod -R u+w ${dir}/hyperhdr
      '';

    source = ../resources/hyperhdr;
  };

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
