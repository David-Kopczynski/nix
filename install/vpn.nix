{ pkgs, ... }:

let
  vpn = pkgs.writeShellApplication {

    name = "vpn";
    runtimeInputs = with pkgs; [ openconnect ] ++ [ bitwarden-cli ] ++ [ libsecret ];
    text = ''
      # Configuration
      bitwarden_entry="c01c571c-0a1b-4c7a-b44f-b29d013a3099"
      user=hg066732

      # Logging into Bitwarden
      session=$(secret-tool lookup bw_session bw_session_key || true)

      if [ -z "$session" ]; then
        echo "no bitwarden session found..."
        bw login --apikey --quiet
        session=$(bw unlock --raw)
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
    '';
  };
in
{
  environment.systemPackages = [ vpn ];
}
