{ pkgs, ... }:

let
  please = pkgs.writeShellApplication {

    name = "please";
    text = ''
      # ---------- switch ---------- #
      if [ "$1" = "switch" ]; then

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
      echo "  switch   <- build NixOS and switch to it"
      echo "  test     <- test if configuration is valid"

      fi
    '';
  };
in
{
  environment.systemPackages = [ please ];
}
