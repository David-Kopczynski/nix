# ❄️ NixOS
I am using [NixOS](https://nixos.org/download/#nix-install-linux) with GNOME and no experimental settings on the stable channel. \
However, multiple other channels are in use, which must be added for this configuration to work.

```bash
VERSION=26.05

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-$VERSION.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-$VERSION nixos
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add https://github.com/Mic92/sops-nix/archive/master.tar.gz sops-nix
```

## 📁 Configuration Structure
This repository is structured into small nix files that are combined to create the system configuration.

Most of the setup will be found within `./install`.
This directory holds all configuration that applies to each host. \
Some directories may also define user settings or switch specific modules to `nixos-unstable` for cutting edge features!

The rest and most specific configuration will be found within `./hosts/$host`.
Each host defines it's own hardware and optional `extra` programs and services it may need. \
However, this discrepancy should be kept as small as possible to avoid overhead.

<details>
<summary>🔨 Installation</summary>

Setup should be straightforward, simply cloning the project and applying the configuration!

```bash
# Go to desired project path
cd ~

# Simply clone
git clone https://github.com/David-Kopczynski/nix.git
cd nix

# Apply and reboot
./setup.sh
sudo nixos-rebuild switch
sudo reboot now
```
*When reusing old configurations, make sure to update the `stateVersion` in the host configuration to the latest version.* \
*For `sops-nix` to work, the SSH keys should be added to `~/.ssh`.*

</details>
