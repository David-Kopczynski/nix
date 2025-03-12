{ config, pkgs, ... }:

{
  # Override electron version until fixed: https://github.com/NixOS/nixpkgs/issues/385588
  environment.systemPackages = with pkgs; [ (webcord.override { electron = electron_32; }) ];
  nixpkgs.config.permittedInsecurePackages = [ "electron-32.3.3" ];

  home-manager.users."user".xdg.configFile."WebCord/_config.json" = {

    # Copy config into place to prevent read-only errors when starting
    onChange =
      let
        dir = "${config.home-manager.users."user".xdg.configHome}/WebCord";
      in
      ''
        rm -f ${dir}/config.json
        cp ${dir}/_config.json ${dir}/config.json
        chmod u+w ${dir}/config.json
      '';

    text = builtins.toJSON {

      # General settings
      settings.advanced.redirection.warn = false;
      settings.general.menuBar.hide = true;
      settings.general.window.hideOnClose = false;

      # General permissions
      settings.privacy.permissions = {
        audio = true;
        display-capture = true;
        fullscreen = true;
        notifications = true;
        video = true;
      };

      # Disable CSP for better compatibility
      # (this also fixes Krisp)
      settings.advanced.csp.enabled = false;
    };
  };
}
