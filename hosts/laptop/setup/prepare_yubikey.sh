#!/usr/bin/env nix-shell
#! nix-shell -i bash -p yubikey-manager
set -o errexit
set -o nounset
set -o pipefail

read -rp "YubiKey Secret (empty for random): " SECRET

if [ -z "$SECRET" ]; then
  ykman otp chalresp --generate 2
else
  ykman otp chalresp 2 "$SECRET"
fi
