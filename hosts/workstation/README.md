# ❄️ Workstation
My **i7 13700kf** + **RTX 2070 Super** workstation is currently running just fine with a basic partition layout.

## 🚀 Setup
Should the UEFI settings be reset, the `profile` configuration file can be found with:

```bash
cd nix/hosts/workstation
nix-shell -p sops --run "sops -d ../../resources/sops/workstation-profile > profile"
```
