{ config, pkgs, ... }:

pkgs.writeShellScriptBin "vpn" ''

    # ---------- rwth ---------- #
    if [ "$1" = "rwth" ]; then

    sudo openconnect --useragent AnyConnect vpn.rwth-aachen.de --authgroup 'RWTH-VPN (Split Tunnel)' --user hg066732

    # ---------- i11 ---------- #
    elif [ "$1" = "i11" ]; then

    sudo openconnect --useragent AnyConnect vpn.i11.rwth-aachen.de --authgroup 'i11-praktikum-VPN(Split-Tunnel)' --user hg066732 --no-external-auth

    # ---------- help ---------- #
    else

    echo "command not found"
    echo "possible commands are:"
    echo "  rwth     <- connect to default rwth vpn"
    echo "  i11      <- connect to i11 embedded vpn using student network"

    fi
''
