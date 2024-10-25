{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 1. add this to the system packages to clone project
    git
    openssh
  ];

  # 2. sudo nixos-rebuild switch to apply
  # 3. create ~/.ssh with mkdir ~/.ssh
  # 4. copy SSH keys into ~/.ssh
  # 5. clone project and run `setup.sh`
  # 6. add secrets to `secrets.nix`
  # 7. apply with sudo nixos-rebuild switch
}
