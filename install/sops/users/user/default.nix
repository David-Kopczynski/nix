{ user }:

{
  # Required to edit secrets via local user
  home-manager.users.${user} =
    { lib, pkgs, ... }:
    {
      home.activation."ssh-to-age" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        SSH_KEY="$HOME/.ssh/id_ed25519"
        AGE_KEY="''${XDG_CONFIG_HOME:-$HOME/.config}/sops/age/keys.txt"

        mkdir -p "dirname $AGE_KEY"
        ${with pkgs; ssh-to-age}/bin/ssh-to-age -private-key -i $SSH_KEY > "$AGE_KEY"
      '';
    };
}
