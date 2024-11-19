{ pkgs, ... }:

let
  vpn = pkgs.writeShellScriptBin "vpn" ''

    # Login to bitwarden for credentials if not already logged in
    # Check if rwth or i11 correctly provided
    if [ "$1" = "rwth" ] || [ "$1" = "i11" ]; then
      sudo echo "logging in to bitwarden..."
      session="$(secret-tool lookup bw_session bw_session_key)"

      # Check if session is still valid
      unlocked=$(bw status --session $session | grep "unlocked")

      if [ -z "$unlocked" ]; then
        session=$(bw unlock --raw)
        echo "$session" | secret-tool store --label='Bitwarden' bw_session bw_session_key
      else
        echo "Already logged in."
      fi
    fi

    # Get password and totp from bitwarden
    password=$(bw get password e5d3a9af-974a-4781-8a8c-ada7009d2a7f --session $session)
    totp=$(bw get totp e5d3a9af-974a-4781-8a8c-ada7009d2a7f --session $session)

    # ---------- rwth ---------- #
    if [ "$1" = "rwth" ]; then

    echo -e "$password\n$totp\n" | sudo openconnect --useragent AnyConnect vpn.rwth-aachen.de --authgroup 'RWTH-VPN (Split Tunnel)' --user hg066732

    # ---------- i11 ---------- #
    elif [ "$1" = "i11" ]; then

    echo -e "$password\n$totp\n" | sudo openconnect --useragent AnyConnect vpn.embedded.rwth-aachen.de --authgroup 'i11-studenten-VPN(Split-Tunnel)' --user hg066732 --no-external-auth

    # ---------- help ---------- #
    else

    echo "command not found"
    echo "possible commands are:"
    echo "  rwth     <- connect to default rwth vpn"
    echo "  i11      <- connect to i11 embedded vpn using student network"

    fi
  '';
in
{
  environment.systemPackages = [
    vpn
    pkgs.openconnect
    pkgs.bitwarden-cli
    pkgs.libsecret
  ];

  # Bitwarden is initially installed using `bw login --apikey`
}
