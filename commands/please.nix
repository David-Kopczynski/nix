{ config, pkgs, ... }:

pkgs.writeShellScriptBin "please" ''

  # ---------- sync ---------- #
  if [ "$1" = "sync" ]; then

  # pull data from user and Nix repository
  # and apply various configuration synchronizations
  echo "staging user..."

  dconf dump / > ~/.config/dconf/user.txt
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

  # remember if nix repo was behind
  git -C ${config.root} remote update
  nix_behind=$(git -C ${config.root} status -uno | grep -q "Your branch is behind" && echo 1 || echo 0)

  echo "pulling Nix..."
  if ! git -C ${config.root} pull; then
    # if conflict occurred, open vscode to resolve manually
    code --wait ~
  fi

  echo "applying user..."
  dconf load / < ~/.config/dconf/user.txt

  echo "applying Nix..."
  if [ "$nix_behind" = 1 ]; then
    echo "Nix repository is behind."
    echo "Switch to new configuration? (yes/no)"
    read switch

    if [ "$switch" = "yes" ] || [ "$switch" = "y" ] || [ "$switch" = "" ]; then
      please switch
    fi
  else
    echo "Nix repository is up to date."
  fi

  echo "pushing user..."
  current_branch=$(git -C ~ rev-parse --abbrev-ref HEAD)
  if git -C ~ diff --quiet origin/$current_branch; then
    echo "No changes to push."
  else
    git -C ~ push
  fi

  echo "pushing Nix..."
  current_branch=$(git -C ${config.root} rev-parse --abbrev-ref HEAD)
  if git -C ${config.root} diff --quiet origin/$current_branch; then
    echo "No changes to push."
  else
    git -C ${config.root} push
  fi

  # ---------- reset ---------- #
  elif [ "$1" = "reset" ]; then

  # reset all changes in user and Nix repository
  if git -C ~ diff --quiet --staged; then
    switch="yes"
  else
    echo "Changes in user repository:"
    echo $(git -C ~ status -s)
    echo "Reset user? (yes/no)"
    read switch
  fi

  if [ "$switch" = "yes" ] || [ "$switch" = "y" ] || [ "$switch" = "" ]; then
    echo "resetting user..."
    git -C ~ reset --hard
    dconf load / < ~/.config/dconf/user.txt
  fi

  if git -C ${config.root} diff --quiet; then
    switch="yes"
  else
    echo "Changes in Nix repository:"
    echo $(git -C ${config.root} status -s)
    echo "Reset Nix? (yes/no)"
    read switch
  fi

  if [ "$switch" = "yes" ] || [ "$switch" = "y" ] || [ "$switch" = "" ]; then
    echo "resetting Nix..."
    git -C ${config.root} reset --hard
  fi

  # ---------- test ---------- #
  elif [ "$1" = "test" ]; then

  # test if configuration is valid
  sudo nixos-rebuild test
  rm result

  # ---------- switch ---------- #
  elif [ "$1" = "switch" ]; then

  echo "cleaning old images..."
  please clean

  # simply build NixOS and switch to it
  echo "switching to new configuration..."
  sudo nixos-rebuild switch

  # ---------- clean ---------- #
  elif [ "$1" = "clean" ]; then

  # limit the number of generations to 10 (-1 as the current generation is not counted)
  # remove all except the last 9 lines from --list-generations and feed them into --delete-generations
  delete_gen=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | head -n -9 | awk '{print $1}' | tr '\n' ' ')
  sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $delete_gen

  sudo nix-collect-garbage

  # ---------- help ---------- #
  else

  echo "command not found"
  echo "possible commands are:"
  echo "  sync     <- sync data from user and Nix repository"
  echo "  reset    <- reset NixOS to the last state"
  echo "  test     <- test if configuration is valid"
  echo "  switch   <- build NixOS and switch to it"
  echo "  clean    <- clean up Nix and old generations"

  fi
''
