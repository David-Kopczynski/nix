# ❄️ NixOS
[NixOS](https://nixos.org/download/#nix-install-linux) is installed with **GNOME** with the following system configuration:

| Setting | Value |
| --- | --- |
| Name | `David Kopczynski` |
| User | `user` |
| Password | *(found in Bitwarden)* |

## 📁 Configuration Structure
When dealing with installations in `.nix`, general hardware, different hosts, and general installations are differentiated as follows:

| Directory | Description |
| --- | --- |
| `./channels` | channel configuration for other configs |
| `./hosts` | specific hardware / system configurations |
| `./install` | general installation configurations |
| `./nixos` | autogenerated system configuration |
| `./resources` | resources for the system |

## 📜 Commands
This repository offers a set of custom commands that can be used to manage the system using `please`:

| Command | Description |
| --- | --- |
| `please clean` | clean the system of old data and generations |
| `please switch` | build the system with the latest data and switch to it |
| `please test` | test build without creating EFI entry point |

When dealing with NixOS, the following native commands can also be used to manage the system:

| Command | Reason |
| --- | --- |
| `nix-shell -p <package>` | install a package temporarily |

## 🖥️ Hosts
Hosts store systematic differences between machines. Currently, [`laptop`](./hosts/laptop.nix) and [`workstation`](./hosts/workstation.nix) are used in this repository.

## 🚀 Setup
When copying the system to a new device it is necessary to add some base configurations to the system in order to clone this repository. The configuration can be found in `./nixos/initial.configuration.nix` while the SSH keys should be copied into `~/.ssh` or generated with `ssh-keygen`. Afterwards, the setup script can be run with `sh setup.sh` to setup all files for the first time. (When migrating the system to another device, the keystore in `~/.local/share/keyrings` should also be copied to the new device.)

Additionally, channels must be subscribed to manually with `sudo nix-channel --add $URL $NAME` and updated with `sudo nix-channel --update`. This setup requires the following channels:

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
```
