cd "$(dirname "$0")"

# ---------- Generate env ---------- #

echo "Generation of environment variables for NixOS setup:"

# Skip if env.nix already exists
if [ -f env.nix ]; then
  echo "env.nix already exists. Skipping generation of environment variables."
else

# Get environment variables for NixOS setup
read -p "Host: " host

# Create env.nix with all necessary environment variables
echo "{ config, lib, ... }:

{
  imports = [ ./hosts/${host}.nix ];

  options = with lib; with types; {
    root = mkOption { type = str; };
    host = mkOption { type = str; };
  };
  config = {
    root = \"$PWD\";
    host = \"$host\";
  };
}" > env.nix

fi

# ---------- NixOS ---------- #

echo ""; echo "NixOS setup:"

# Generate configuration.nix with current location via pwd
echo "{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    $(pwd)
  ];
}" | sudo tee /etc/nixos/configuration.nix

# Rebuild to include all modules
sudo nixos-rebuild switch
