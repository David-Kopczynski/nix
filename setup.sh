#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

read -rp "Host: " host
echo "{ imports = [ $(realpath $(dirname "$0"))/hosts/$host $(realpath $(dirname "$0"))/default.nix ]; }" \
  > /etc/nixos/configuration.nix
