{ config, pkgs, ... }:

pkgs.writeShellScriptBin "please" ''

    # ---------- sync ---------- #
    if [ "$1" = "sync" ]; then

    # pull data from user and nix repository
    # and apply various configuration synchronizations
    echo "staging user..."
    dconf dump / > ~/.config/dconf/user.txt

    # cleanup dconf from host related settings
    # select all lines that do not start with "[" (section header)
    # and remove all that are host related
    sed -i '/^[^\[]*\b\(window\|width\|height\|size\|maximized\|panel\|last-\|active-\|keyring\)\b/d' ~/.config/dconf/user.txt

    # cleanup dconf from settings that have no configuration
    sed -i '/^\[.*\]$/{N;/\n$/d}' ~/.config/dconf/user.txt

    git -C ~ add .

    if git -C ~ diff --quiet --staged; then
        echo "No changes to commit."
    else
        git -C ~ diff --staged

        echo "Please enter a commit message:"
        read commit_message
        git -C ~ commit -m "$commit_message"
    fi

    echo "pulling user..."
    if ! git -C ~ pull; then
        # if conflict occurred, open vscode to resolve manually
        code --wait ~
    fi

    echo "pulling nix..."
    if ! git -C ${config.root} pull; then
        # if conflict occurred, open vscode to resolve manually
        code --wait ~
    fi

    echo "applying user..."
    dconf load / < ~/.config/dconf/user.txt

    echo "pushing user..."
    current_branch=$(git -C ~ rev-parse --abbrev-ref HEAD)
    if git -C ~ diff --quiet origin/$current_branch; then
        echo "No changes to push."
    else
        git -C ~ push
    fi

    echo "pushing nix..."
    current_branch=$(git -C ${config.root} rev-parse --abbrev-ref HEAD)
    if git -C ${config.root} diff --quiet origin/$current_branch; then
        echo "No changes to push."
    else
        git -C ${config.root} push
    fi

    # ---------- test ---------- #
    elif [ "$1" = "test" ]; then

    # test if configuration is valid
    sudo nixos-rebuild test
    rm result

    # ---------- switch ---------- #
    elif [ "$1" = "switch" ]; then

    # simply build nixos and switch to it
    sudo nixos-rebuild switch

    # ---------- clean ---------- #
    elif [ "$1" = "clean" ]; then

    # delete old generations and garbage collect
    echo "deleting old generations..."
    sudo nix-collect-garbage --delete-older-than 7d
    sudo /run/current-system/bin/switch-to-configuration boot

    # ---------- help ---------- #
    else

    echo "command not found"
    echo "possible commands are:"
    echo "  sync     <- sync data from user and nix repository"
    echo "  test     <- test if configuration is valid"
    echo "  switch   <- build nixos and switch to it"

    fi
''
