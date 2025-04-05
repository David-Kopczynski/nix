#!/usr/bin/env nix-shell
#! nix-shell -i bash -p disko
set -o errexit
set -o nounset
set -o pipefail

cd $(dirname "$0")

sudo disko --mode disko disko.nix
sudo mkdir -p /mnt/etc/nixos
sudo cp install.nix /mnt/etc/nixos/configuration.nix
sudo nixos-install
