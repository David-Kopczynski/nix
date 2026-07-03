{ user }:
{ config, lib, ... }:

lib.mkIf (config.system.name == "workstation") {
  home-manager.users.${user} =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Writable config directory
      xdg.configFile."_hyperhdr" = {

        # Copy config into place to prevent read-only errors
        onChange =
          let
            dir = config.xdg.configHome;
          in
          ''
            rm -rf ${dir}/hyperhdr
            cp -rL ${dir}/_hyperhdr ${dir}/hyperhdr
            chmod -R u+w ${dir}/hyperhdr
          '';

        source = ./hyperhdr;
      };

      # Autostart HyperHDR after complete login
      xdg.configFile."autostart/hyperhdr.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=HyperHDR
        Exec=systemctl --user start hyperhdr.service
        X-GNOME-Autostart-enabled=true
        OnlyShowIn=GNOME;
      '';

      # Prevent screen lock
      dconf.settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;

      # Enable extension
      dconf.settings."org/gnome/shell".enabled-extensions = with pkgs; [
        gnomeExtensions.disable-unredirect.extensionUuid
      ];

      # Keybindings for HyperHDR service management
      dconf.settings."org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-hyperhdr/"
        ];
      };

      dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-hyperhdr" = {
        name = "hyperhdr";
        command = "systemctl --user restart hyperhdr.service";
        binding = "<Control><Alt>numbersign";
      };
    };

  # Allow serial port access
  users.users.${user}.extraGroups = [ "dialout" ];
}
