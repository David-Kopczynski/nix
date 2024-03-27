cd "$(dirname "$0")"

# ---------- Generate env ---------- #

# Skip if .env.nix already exists
if [ -f .env.nix ]; then
  echo ".env.nix already exists. Skipping generation of environment variables."
else

# Get environment variables for NixOS setup
echo "Generation of environment variables for NixOS setup:"
read -p "Host: " host

# Create .env.nix with all necessary environment variables
touch .env.nix
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

# Create correct hardlink for host.nix inclusion
ln "hosts/${host}/host.nix" hosts/host.nix

fi

# ---------- NixOS ---------- #

# Generate configuration.nix with current location via pwd
touch nixos/configuration.nix
echo "{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      $(pwd)/index.nix
    ];
}" > nixos/configuration.nix

# Copy hardware-configuration into new location for further use and delete old config
rm /etc/nixos/configuration.nix
mv /etc/nixos/hardware-configuration.nix nixos

# Update permissions of files and folder
chmod 644 nixos/configuration.nix
chmod 644 nixos/hardware-configuration.nix

# Create hardlinks from /etc/nixos to ./nixos for better file management
ln nixos/configuration.nix /etc/nixos/configuration.nix
ln nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# Add all missing channels
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update

# Rebuild to include all modules
nixos-rebuild switch

# ---------- Home Manager ---------- #

# Init home-manager for default home file and delete it immediately
home-manager init
rm ~/.config/home-manager/home.nix

# Create hardlink from ~/.config/home-manager to ./modules/home-manager for better file management
ln modules/home-manager/home.nix ~/.config/home-manager/home.nix

# Apply home-manager configuration
home-manager switch
