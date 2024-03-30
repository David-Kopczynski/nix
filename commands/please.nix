{ config, pkgs, ... }:

pkgs.writeShellScriptBin "please" ''

    # ---------- add ---------- #
    if [ "$1" = "add" ]; then

    # Pass arguments to git add script in user repository
    shift
    sh ~/gitadd "$@"

    # ---------- pull ---------- #
    elif [ "$1" = "pull" ]; then

    # pull data from user and nix repository
    echo "pulling user..."
    git -C ~ pull

    echo "pulling nix..."
    git -C ${config.root} pull

    # ---------- switch ---------- #
    elif [ "$1" = "switch" ]; then

    # simply build nixos and switch to it
    sudo nixos-rebuild switch

    # ---------- help ---------- #
    else

    echo "command not found"
    echo "possible commands are:"
    echo "  add      <- add files to user repository"
    echo "  pull     <- pull data from user and nix repository"
    echo "  switch   <- build nixos and switch to it"

    fi
''
