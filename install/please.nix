{ pkgs, ... }:

let
  please = pkgs.writeShellApplication {

    name = "please";
    runtimeInputs = with pkgs; [ nix-output-monitor ] ++ [ nvd ];
    text = ''
      # ---------- switch ---------- #
      if [ $# -ge 1 ] && [ "$1" = "switch" ]; then

      sudo echo "update channels..."
      sudo nix-channel --update

      # simply build NixOS and switch to it
      sudo echo "switching to new configuration..."
      OLD_GEN=$(readlink -f /run/current-system)
      sudo nixos-rebuild switch --log-format internal-json |& nom --json
      NEW_GEN=$(readlink -f /run/current-system)
      nvd diff "$OLD_GEN" "$NEW_GEN"

      # ---------- test ---------- #
      elif [ $# -ge 1 ] && [ "$1" = "test" ]; then

      # test if configuration is valid
      sudo echo "testing configuration..."
      sudo nixos-rebuild test --fast --log-format internal-json |& nom --json && rm result

      # ---------- help ---------- #
      else

      echo "command not found"
      echo "possible commands are:"
      echo "  switch   <- build NixOS and switch to it"
      echo "  test     <- test if configuration is valid"

      fi
    '';
  };
in
{
  environment.systemPackages = [ please ];
}
