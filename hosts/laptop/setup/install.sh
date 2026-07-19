#!/usr/bin/env nix-shell
#! nix-shell -i bash -p disko

disko --mode destroy,format,mount "$(dirname $0)/disko.nix"
nixos-generate-config --root /mnt
cp "$(dirname $0)/install.nix" /mnt/etc/nixos/configuration.nix
nixos-install
