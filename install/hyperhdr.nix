{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  systemd.user.services."hyperhdr" = {

    description = "HyperHDR Ambient Light Systemd Service";

    after = [ "graphical-session.target" ];
    bindsTo = [ "graphical-session.target" ];

    serviceConfig = {

      ExecStart = "${
        pkgs.writeShellApplication {

          name = "hyperhdr-wrapper";
          runtimeInputs = with pkgs; [ hyperhdr ];
          text = ''
            exec hyperhdr --pipewire --userdata ${config.home-manager.users."user".xdg.configHome}/hyperhdr
          '';
        }
      }/bin/hyperhdr-wrapper";

      KillMode = "mixed";
      TimeoutStopSec = "5s";
    };
  };

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

  # Autostart HyperHDR after complete login
  home-manager.users."user".xdg.configFile."autostart/hyperhdr.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=HyperHDR
    Exec=systemctl --user start hyperhdr.service
    X-GNOME-Autostart-enabled=true
    OnlyShowIn=GNOME;
  '';

  # Prevent fullscreen pipewire issues
  environment.systemPackages = with pkgs; [ gnomeExtensions.disable-unredirect ];

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Prevent screen lock
    settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [ gnomeExtensions.disable-unredirect.extensionUuid ];
    };

    # Keybindings for HyperHDR service management
    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-hyperhdr/"
      ];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-hyperhdr" = {
      name = "hyperhdr";
      command = "systemctl --user restart hyperhdr.service";
      binding = "<Control><Alt>numbersign";
    };
  };

  users.users."user".extraGroups = [ "dialout" ];
}
