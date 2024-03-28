{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "pc") {

    # Run de.psieg.Prismatik at startup    
    systemd.user.services.prismatik = {
        enable = true;

        description = "Prismatik Ambilight Daemon";
        wantedBy = [ "xdg-desktop-autostart.target" ];
        serviceConfig = {
            Type = "forking";
            ExecStart = ''${pkgs.flatpak}/bin/flatpak run de.psieg.Prismatik'';
            ExecStop = ''${pkgs.flatpak}/bin/flatpak kill de.psieg.Prismatik'';
        };
    };
}
