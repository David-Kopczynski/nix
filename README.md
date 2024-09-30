# ❄️ NixOS
[NixOS](https://nixos.org/download/#nix-install-linux) is installed with **Plasma Desktop** with the following system configuration:

| Setting | Value |
| --- | --- |
| Name | `David Kopczynski` |
| User | `user` |
| Password | *(found in Bitwarden)* |

## 📁 Configuration Structure
When dealing with installations in `.nix`, programs and services are to be preferred to simple package installments. This repo is structured as follows:

| Directory | Description |
| --- | --- |
| `./hosts` | general system configurations |
| `./nixos` | system configurations |
| [`./packages`](https://search.nixos.org/packages) | system packages that are simply installed |
| [`./programs`](https://search.nixos.org/options) | system programs that are installed and configured *(preferred)* |
| [`./services`](https://search.nixos.org/options) | system services that are installed and configured *(preferred)* |

## 📜 Commands
This repository offers a set of custom commands that can be used to manage the system using `please` in combination with [user](https://github.com/David-Kopczynski/user):

| Command | Description |
| --- | --- |
| `please sync` | sync all user and nix data from git |
| `please test` | test build without creating EFI entry point |
| `please switch` | build the system with the latest data and switch to it |

When dealing with NixOS, the following native commands can also be used to manage the system:

| Command | Reason |
| --- | --- |
| `sudo nixos-rebuild switch` | build and deploy new system packages |
| `nix-shell -p <package>` | install a package temporarily |
| `nix-channel --update` | update packages at system level |

## 🖥️ Hosts
Hosts store systematic differences between machines. Currently, [`laptop`](https://github.com/NixOS/nixos-hardware/tree/master/framework) and `workstation` are used in this repository. Furthermore, when dealing with specific hardware it can be necessary to run the following commands for some configuration:

| Command | Reason |
| --- | --- |
| `fprintd-enroll` | enroll fingerprint reader |

## 🚀 Setup
When copying the system to a new device it is necessary to add some base configurations to the system in order to clone this repository. The configuration can be found in `./nixos/initial.configuration.nix` while the SSH keys should be copied into `~/.ssh` or generated with `ssh-keygen`. Afterwards, the setup script can be run with `sh setup.sh` to setup all files for the first time. (When migrating the system to another device, the keystore in `~/.local/share/keyrings` should also be copied to the new device.)


# Rework....

Channels must be subscribed to manually with `nix-channel --add $URL $NAME` and updated with `nix-channel --update`. This setup requires the following channels:

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
```
