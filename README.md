# NixOS
[NixOS](https://nixos.org/download/#nix-install-linux) is installed with **Plasma Desktop** with the following system configuration:

| Setting | Value |
| --- | --- |
| Name | `David Kopczynski` |
| User | `user` |
| Password | *(found in Bitwarden)* |

When dealing with [packages](https://search.nixos.org/packages) or [home-manager options](https://home-manager-options.extranix.com/?) it is helpful to read the appropriate documentation.

Additionally, the following commands will be often used:

| Command | Reason |
| --- | --- |
| `sudo nixos-rebuild switch` | build and deploy new system packages |
| `nix-shell -p <package>` | install a package temporarily |
| `nix-channel --update` | update packages at system level |

When dealing not-synced files, changes must be applied manually with: 

| Action | Reason |
| --- | --- |
| `sh apply.sh` | apply changes to the system |
| `sh backup.sh` | backup changes to the system |

When copying the system to a new device it is necessary to generate or copy additional files:

| Action | Reason |
| --- | --- |
| Initial git clone | add config from `nixos/initial.configuration.nix` for first clone |
| Add SSH keys | `ssh-keygen` *(or ideally copy the SSH from the other device into `~/.ssh`)* |
| Setup | run `sh setup.sh` to setup all files for the first time |
