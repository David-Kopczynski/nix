cd "$(dirname "$0")"

# ---------- Generate env ---------- #

echo "Generation of environment variables for NixOS setup:"

# Skip if env.nix already exists
if [ -f env.nix ]; then
  echo "env.nix already exists. Skipping generation of environment variables."
else

# Get environment variables for NixOS setup
read -p "Host: " host

# Create env.nix with all necessary environment variables
echo "{ lib, ... }:

{
  imports = [ ./hosts/${host}.nix ];

  options = with lib; {
    root = mkOption { type = types.str; };
    host = mkOption { type = types.str; };
    user = mkOption { type = types.str; };
  };
  config = {
    root = \"$PWD\";
    host = \"$host\";
    user = \"user\";
  };
}" > env.nix

fi

# ---------- Generate secrets ---------- #

echo ""; echo "Generation of secrets for NixOS setup:"

# Skip if secrets.nix already exists
if [ -f secrets.nix ]; then
  echo "secrets.nix already exists. Skipping generation of secrets."
else

# Create secrets.nix with base structure
echo "{ lib, ... }:

{
  options.secrets = with lib; {
    homeassistant.token = mkOption { type = types.str; };
  };
  config.secrets = {
    homeassistant.token = \"\";
  };
}" > secrets.nix

fi
