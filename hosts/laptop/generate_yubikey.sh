#!/usr/bin/env nix-shell
#! nix-shell -i bash -p yubikey-personalization openssl
set -o errexit
set -o nounset
set -o pipefail

SECRET=$(openssl rand -hex 20)
ykpersonalize -2 -ochal-resp -ochal-hmac -a$SECRET
