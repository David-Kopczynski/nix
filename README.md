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
When dealing with NixOS, the following commands will be often used to manage the system:

| Command | Reason |
| --- | --- |
| `sudo nixos-rebuild switch` | build and deploy new system packages |
| `nix-shell -p <package>` | install a package temporarily |
| `nix-channel --update` | update packages at system level |

## 🚀 Setup
When copying the system to a new device it is necessary to add some base configurations to the system in order to clone this repository. The configuration can be found in `./nixos/initial.configuration.nix` while the SSH keys should be copied into `~/.ssh` or generated with `ssh-keygen`. Afterwards, the setup script can be run with `sh setup.sh` to setup all files for the first time.
