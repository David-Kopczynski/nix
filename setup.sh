cd "$(dirname "$0")"

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

# ---------- Home Manager ---------- #

# Add home manager to channels
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update

# Create hardlink from ~/.config/home-manager to ./modules/home-manager for better file management
ln modules/home-manager/home.nix ~/.config/home-manager/home.nix
