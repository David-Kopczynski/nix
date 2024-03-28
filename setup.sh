cd "$(dirname "$0")"

# ---------- Generate env ---------- #

echo "Generation of environment variables for NixOS setup:"

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

fi

# ---------- NixOS ---------- #

echo ""; echo "NixOS setup:"

# Skip if config already setp
if [ -f nixos/configuration.nix ]; then
  echo "NixOS configuration already set up. Skipping NixOS setup."
else

# Generate configuration.nix with current location via pwd
touch nixos/configuration.nix
echo "{
    imports = [ 
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        $(pwd)/index.nix
    ];
}" > nixos/configuration.nix

# Copy hardware-configuration into new location for further use and delete old config
sudo rm /etc/nixos/configuration.nix
sudo mv /etc/nixos/hardware-configuration.nix nixos

# Update permissions of files and folder
sudo chmod 644 nixos/configuration.nix
sudo chmod 644 nixos/hardware-configuration.nix

# Create hardlinks from /etc/nixos to ./nixos for better file management
sudo ln nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

fi

# Allow unfree packages in command line
mkdir -p ~/.config/nixpkgs
echo "{ allowUnfree = true; }" > ~/.config/nixpkgs/config.nix

# Add all missing channels
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update

# Rebuild to include all modules
sudo nixos-rebuild switch

# ---------- Home Manager ---------- #

echo ""; echo "Home Manager setup:"

# Skip if home.nix already set up
if [ -f ~/.config/home-manager/home.nix ]; then
  echo "Home Manager configuration already set up. Skipping Home Manager setup."
else

# Init home-manager for default home file and delete it immediately
home-manager init
rm ~/.config/home-manager/home.nix

# Create hardlink from ~/.config/home-manager to ./modules/home-manager for better file management
ln modules/home-manager/home.nix ~/.config/home-manager/home.nix

# Apply home-manager configuration
home-manager switch

fi

# ---------- Flatpaks ---------- #

echo ""; echo "Flatpak setup:"

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Install prismatik flatpak when on pc
if [ "$host" = "pc" ]; then

# Skip if prismatik already installed
if [ -f modules/lightpack/prismatik.flatpak ]; then
  echo "Prismatik already installed. Skipping installation of Prismatik."
else

wget -O modules/lightpack/prismatik.flatpak https://github.com/psieg/Lightpack/releases/download/5.11.2.31/prismatik_5.11.2.31.flatpak
flatpak install modules/lightpack/prismatik.flatpak
sudo flatpak override --filesystem=host com.prismatik.Prismatik

fi

fi

# ---------- Final ---------- #

echo ""; echo "Final setup:"

# Apply all manual configurations
sh apply.sh
