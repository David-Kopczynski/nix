cd "$(dirname "$0")"

# Setup correct host
read -p "Host: " host
echo "{ imports = [ (/. + \"$PWD/hosts/$host.nix\") (/. + \"$PWD/default.nix\") ]; }" > /etc/nixos/configuration.nix
