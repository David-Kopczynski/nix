#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname "$0")"

# Setup correct host
read -rp "Host: " host
echo "{ imports = [ (/. + \"$PWD/hosts/$host.nix\") (/. + \"$PWD/default.nix\") ]; }" > /etc/nixos/configuration.nix
