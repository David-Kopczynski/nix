#!/usr/bin/env nix-shell
#! nix-shell -i bash luks_add_backup_password.nix
set -o errexit
set -o nounset
set -o pipefail

ITERATIONS=1000000

rbtohex() { (od -An -vtx1 | tr -d ' \n') }
hextorb() { (tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI'| xargs printf) }

echo "Waiting for YubiKey to appear..."
while ! ykinfo -v 1>/dev/null 2>&1; do sleep 1; done

SALT="$(head -n1 /boot/crypt-storage/default | tr -d '\n')"
CHALLENGE="$(echo -n "$SALT" | openssl dgst -binary -sha512 | rbtohex)"
RESPONSE="$(ykchalresp -2 -x $CHALLENGE 2>/dev/null)"
LUKS_KEY="$(echo | pbkdf2-sha512 $((512 / 8)) $ITERATIONS $RESPONSE | rbtohex)"

KEYFILE=$(mktemp)
echo -n "$LUKS_KEY" | hextorb > $KEYFILE

sudo cryptsetup luksAddKey --key-file $KEYFILE --verify-passphrase /dev/disk/by-partlabel/disk-system-crypted

rm $KEYFILE
