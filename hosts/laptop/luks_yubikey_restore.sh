#!/usr/bin/env nix-shell
#! nix-shell -i bash -p yubikey-personalization
set -o errexit
set -o nounset
set -o pipefail

read -rp SECRET
ykpersonalize -2 -ochal-resp -ochal-hmac -a"$SECRET"
