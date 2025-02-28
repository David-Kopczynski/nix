{ pkgs, ... }:

let
  vpn = pkgs.writeShellApplication {

    name = "vpn";
    runtimeInputs = with pkgs; [
      openconnect
      bitwarden-cli
      libsecret
    ];
    text = ''
      # Configuration
      bitwarden_entry="e5d3a9af-974a-4781-8a8c-ada7009d2a7f"
      user=hg066732

      # Logging into Bitwarden
      session=$(secret-tool lookup bw_session bw_session_key)

      if [ -z "$session" ]; then
        echo "no bitwarden session found..."
        session=$(bw login --apikey)
        echo "$session" | secret-tool store --label="Bitwarden" bw_session bw_session_key
      fi

      if bw status --session "$session" | grep -q "unlocked"; then
        echo "bitwarden session expired..."
        session=$(bw unlock --raw)
        echo "$session" | secret-tool store --label="Bitwarden" bw_session bw_session_key
      fi

      # Change the UUID to the one of your VPN credentials
      password=$(bw get password "$bitwarden_entry" --session "$session")
      totp=$(bw get totp "$bitwarden_entry" --session "$session")

      # ---------- rwth ---------- #
      if [ $# -gt 0 ] && [ "$1" = "rwth" ]; then

      # Select authgroup
      echo "Select authgroup:"
      groups=$(echo "" | openconnect --useragent AnyConnect vpn.rwth-aachen.de 2>&1 | grep -Po "GROUP: \[\K[^]]+" | uniq | tr "|" "\n") || true
      echo "$groups" | nl
      read -p "Num: " -r selection
      authgroup=$(echo "$groups" | sed -n "$selection p")

      if [ -z "$authgroup" ]; then
        echo "no authgroup selected..."
        exit 1
      fi

      echo -e "$password\n$totp\n" | sudo openconnect --useragent AnyConnect vpn.rwth-aachen.de --authgroup "$authgroup" --user "$user"

      # ---------- i11 ---------- #
      elif [ $# -gt 0 ] && [ "$1" = "i11" ]; then

      # Select authgroup
      echo "Select authgroup:"
      groups=$(echo "" | openconnect --useragent AnyConnect vpn.embedded.rwth-aachen.de 2>&1 | grep -Po "GROUP: \[\K[^]]+" | uniq | tr "|" "\n") || true
      echo "$groups" | nl
      read -p "Num: " -r selection
      authgroup=$(echo "$groups" | sed -n "$selection p")

      if [ -z "$authgroup" ]; then
        echo "no authgroup selected..."
        exit 1
      fi

      echo -e "$password\n$totp\n" | sudo openconnect --useragent AnyConnect vpn.embedded.rwth-aachen.de --authgroup "$authgroup" --user "$user" --no-external-auth

      # ---------- help ---------- #
      else

      echo "command not found"
      echo "possible commands are:"
      echo "  rwth     <- connect to default rwth vpn"
      echo "  i11      <- connect to i11 embedded vpn using student network"

      fi
    '';
  };
in
{
  environment.systemPackages = [ vpn ];
}
