# NixOS
[NixOS](https://nixos.org/download/#nix-install-linux) is installed with **Plasma Desktop** with the following system configuration:

| Setting | Value |
| --- | --- |
| Name | `David Kopczynski` |
| User | `user` |
| Password | *(found in Bitwarden)* |

When dealing with [packages](https://search.nixos.org/packages) or [home-manager options](https://nix-community.github.io/home-manager/options.xhtml) it is helpful to read the appropriate documentation.

Additionally, the following commands will be often used:

| Command | Reason |
| --- | --- |
| `sudo nixos-rebuild switch` | build and deploy new system packages |
| `home-manager switch` | build and deploy new user packages |
| `nix-channel --update` | update packages at system level |

When copying the system to a new device it is necessary to generate or copy additional files:

| Action | Reason |
| --- | --- |
| Setup | run `sh setup.sh` to setup all files for the first time |
| Install correct system | run `sh hosts/*/install.sh` to set correct host |
| Add SSH keys | `ssh-keygen` *(or ideally copy the SSH from the other device into `~/.ssh`)* |
