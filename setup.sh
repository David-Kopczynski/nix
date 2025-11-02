#!/usr/bin/env bash

read -rp "Host: " host
echo "{ imports = [ (/. + \"$(realpath $(dirname "$0"))/hosts/$host.nix\") (/. + \"$(realpath $(dirname "$0"))/default.nix\") ]; }" > /etc/nixos/configuration.nix
