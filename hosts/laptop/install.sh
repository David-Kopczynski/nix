#!/usr/bin/env nix-shell
#! nix-shell -i bash -p disko
set -o errexit
set -o nounset
set -o pipefail

sudo disko --mode disko disko.nix
sudo nixos-install -I nixos-config=install.nix
