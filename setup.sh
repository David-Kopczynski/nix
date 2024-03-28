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

fi

# ---------- NixOS ---------- #

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
rm /etc/nixos/configuration.nix
mv /etc/nixos/hardware-configuration.nix nixos

# Update permissions of files and folder
chmod 644 nixos/configuration.nix
chmod 644 nixos/hardware-configuration.nix

# Create hardlinks from /etc/nixos to ./nixos for better file management
ln nixos/configuration.nix /etc/nixos/configuration.nix
ln nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# Allow unfree packages in command line
mkdir -p ~/.config/nixpkgs
echo "{ allowUnfree = true; }" >> ~/.config/nixpkgs/config.nix

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

# ---------- Flatpaks ---------- #

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Install prismatik flatpak when on pc
if [ "$host" = "pc" ]; then

wget -O modules/lightpack/prismatik.flatpak https://github.com/psieg/Lightpack/releases/download/5.11.2.31/prismatik_5.11.2.31.flatpak
flatpak install modules/lightpack/prismatik.flatpak
flatpak override --filesystem=host com.prismatik.Prismatik

# Create hardlinks for all prismatik configuration
mkdir -p ~/.Prismatik/Profiles
ln modules/lightpack/.Prismatik/main.conf ~/.Prismatik/main.conf
ln modules/lightpack/.Prismatik/Profiles/Screencapture.ini ~/.Prismatik/Profiles/Screencapture.ini
ln modules/lightpack/.Prismatik/Profiles/Cinema.ini ~/.Prismatik/Profiles/Cinema.ini

fi

# ---------- Konsave ---------- #

# Apply current themes
sudo sh modules/konsave/apply.sh
