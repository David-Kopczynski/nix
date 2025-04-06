# ❄️ NixOS
[NixOS](https://nixos.org/download/#nix-install-linux) is installed with **GNOME** with the following system configuration:

| Setting | Value |
| --- | --- |
| Name | `David Kopczynski` |
| User | `user` |
| Password | *(found in Bitwarden)* |

More specific installation instructions can be found in `./hosts/{hostname}/README.md`.

## 📁 Configuration Structure
This repository is structured into small nix files that are combined to create the system configuration. The general structure is as follows:

| Directory | Description |
| --- | --- |
| `./channels` | channel configuration |
| `./derivations` | custom derivations for the system |
| `./hosts` | specific hardware / system configurations |
| `./install` | general installation configurations |
| `./resources` | resources for the system |

## 🚀 Setup
When copying the system to a new device it is necessary to add some base configuration to the system in order to clone this repository (git, ssh). Afterwards, the setup script can be run with `sh setup.sh` to load this repository for the first time (when migrating the system to another device, the keystore in `~/.local/share/keyrings` should also be copied to the new device, as well as the SSH keys in `~/.ssh`), followed by `sudo nixos-rebuild switch` to build the system.

Additionally, channels must be subscribed to manually with `sudo nix-channel --add $URL $NAME` and updated with `sudo nix-channel --update`. This setup requires the following channels:

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-24.11 nixos
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add https://github.com/Mic92/sops-nix/archive/master.tar.gz sops-nix
```

*When reusing old configurations, make sure to update the `stateVersion` in the host configuration to the latest version.*
