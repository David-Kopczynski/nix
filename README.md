# ❄️ NixOS
I am using [NixOS](https://nixos.org/download/#nix-install-linux) with GNOME,
leveraging [npins](https://github.com/andir/npins) with [nh](https://github.com/nix-community/nh)
and [sops-nix](https://github.com/mic92/sops-nix) on the stable channel.

Thus, default tools may not work as expected. \
Please use `npins` and `nh` as shown below.

```bash
# Update dependencies (if required)
npins -d ~/nix/npins update

# 'test', 'boot' or 'switch' configuration
nh os switch -f ~/nix/hosts/$host/system.nix
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

**Setup is not straightforward due to initial provisioning for secrets.** \
**Also, make sure that this repository is available for installation.**

Given a host, we will be starting with the basic partitioning and a bare bones installation.
For this, a simple install script for the desired host will be run.
Afterwards, secrets can be setup and the actual system installed.

Boot from a live USB and change TTY (Ctrl+Alt+Fx) to use the terminal. \
Then, the following steps should be followed loosely for installation. \
*This installation will automatically prompt for any input, installing a base configuration.*

```bash
# All commands can/must be run privileged
sudo -i

# I use a different keyboard layout
loadkeys de

# Install and check for errors
./nix/hosts/$host/setup/install.sh

# Check setup
reboot now
```

Should the system boot properly, secrets can be tweaked. \
*A mount with my known SSH-Keys should be provided and host keys updated accordingly.*

```bash
# Source tools
nix-shell -p nh npins ssh-to-age yq-go

# Source user keys
cp -rp /mnt/.../.ssh ~/

# Prepare sops-nix
mkdir -p ~/.config/sops/age
ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt

# Update hosts age (if required)
export age=$(sudo cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age)
yq '(.keys.hosts[] | select(anchor == "$host")) = env(age)' -i .sops.yaml

# Add hosts age (if required)
export age=$(sudo cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age)
yq '.keys.hosts += env(age) | .keys.hosts[-1] anchor |= "$host"' -i .sops.yaml
nano .sops.yaml # manual modification required

# Update secrets (if required)
sops updatekeys $(find . -type f) 2>/dev/null

# Prepare npins
npins -d ~/nix/npins init

# Install and reboot
nh os switch -f ~/nix/hosts/$host/system.nix -- --extra-experimental-features nix-command
sudo reboot now
```
*When reusing old configurations, make sure to update the `stateVersion` in the host configuration to the latest version.*

</details>
