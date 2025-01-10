{ pkgs, ... }:

let
  please = pkgs.writeShellScriptBin "please" ''
    set -e -u -o pipefail

    # ---------- clean ---------- #
    if [ "$1" = "clean" ]; then

    N=''${2:-10};
    # limit the number of generations to $N;
    sudo nix-env --delete-generations +$N;

    n=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l);
    if [ $n -gt $N ]; then
      echo "Just a heads-up that more than the expected $N generations are currently alive. This is likely due to you having had rolled back from the latest generation before running this command."
    fi

    sudo nix-collect-garbage

    # ---------- optimize ---------- #
    elif [ "$1" = "optimize" ]; then

    # optimize Nix store
    echo "optimizing store..."
    sudo nix-store --optimise

    # ---------- switch ---------- #
    elif [ "$1" = "switch" ]; then

    echo "update channels..."
    sudo nix-channel --update

    # simply build NixOS and switch to it
    echo "switching to new configuration..."
    sudo nixos-rebuild switch

    echo "cleaning old images..."
    please clean

    # ---------- test ---------- #
    elif [ "$1" = "test" ]; then

    # test if configuration is valid
    echo "testing configuration..."
    sudo nixos-rebuild test --fast && rm result

    # ---------- help ---------- #
    else

    echo "command not found"
    echo "possible commands are:"
    echo "  clean    <- clean up Nix and old generations"
    echo "  optimize <- optimize Nix store"
    echo "  switch   <- build NixOS and switch to it"
    echo "  test     <- test if configuration is valid"

    fi
  '';
in
{
  environment.systemPackages = [ please ];
}
