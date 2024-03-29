{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "workstation") {

    # Services started with possible configuration
    # Options can be found in https://search.nixos.org/options
    services = {

    };

    # Run de.psieg.Prismatik at startup
    systemd.user.services.prismatik = {
        enable = true;

        description = "Prismatik Ambilight Daemon";
        wantedBy = [ "xdg-desktop-autostart.target" ];
        serviceConfig = {
            Type = "forking";
            ExecStart = ''${pkgs.flatpak}/bin/flatpak run --filesystem=host de.psieg.Prismatik'';
            ExecStop = ''${pkgs.flatpak}/bin/flatpak kill de.psieg.Prismatik'';
        };
    };
}
