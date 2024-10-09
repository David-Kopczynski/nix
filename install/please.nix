{ config, pkgs, ... }:

let
  please = pkgs.writeShellScriptBin "please" ''

  # ---------- clean ---------- #
  if [ "$1" = "clean" ]; then

  # limit the number of generations to 10 (-1 as the current generation is not counted)
  # remove all except the last 9 lines from --list-generations and feed them into --delete-generations
  delete_gen=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | head -n -9 | awk '{print $1}' | tr '\n' ' ')
  sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $delete_gen

  sudo nix-collect-garbage

  # ---------- switch ---------- #
  elif [ "$1" = "switch" ]; then

  echo "cleaning old images..."
  please clean

  echo "update channels..."
  sudo nix-channel --update

  # simply build NixOS and switch to it
  echo "switching to new configuration..."
  sudo nixos-rebuild switch

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
  echo "  switch   <- build NixOS and switch to it"
  echo "  test     <- test if configuration is valid"

  fi
'';
in
{
  environment.systemPackages = [ please ];
}
