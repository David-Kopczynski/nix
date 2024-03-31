cd "$(dirname "$0")"

# ---------- Generate env ---------- #

echo "Generation of environment variables for NixOS setup:"

# Skip if .env.nix already exists
if [ -f .env.nix ]; then
  echo ".env.nix already exists. Skipping generation of environment variables."
else

# Get environment variables for NixOS setup
read -p "Host: " host

# Create .env.nix with all necessary environment variables
echo "{ config, lib, ... }:

{
    options = with lib; with types; {
        root = mkOption { type = str; };
        host = mkOption { type = str; };
    };
    config = {
        root = \"$PWD\";
        host = \"$host\";
    };
}" > .env.nix

# Softlink correct host configuration
ln hosts/$host.nix hosts/default.nix

fi

# ---------- NixOS ---------- #

echo ""; echo "NixOS setup:"

# Skip if config already setp
if [ -f nixos/configuration.nix ]; then
  echo "NixOS configuration already set up. Skipping NixOS setup."
else

# Generate configuration.nix with current location via pwd
echo "{
    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        $(pwd)
    ];
}" > nixos/configuration.nix

# Copy hardware-configuration into new location for further use and delete old config
sudo rm /etc/nixos/configuration.nix
sudo mv /etc/nixos/hardware-configuration.nix nixos

# Update permissions of files and folder
sudo chmod 644 nixos/configuration.nix nixos/hardware-configuration.nix

# Create hardlinks from /etc/nixos to ./nixos for better file management
sudo ln nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

fi

# Rebuild to include all modules
sudo nixos-rebuild switch
