{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [ gnomeExtensions.executor ];

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [ gnomeExtensions.executor.extensionUuid ];
    };

    # Custom settings
    settings."org/gnome/shell/extensions/executor" = {

      center-active = true;
      center-commands-json = builtins.toJSON {
        commands = [
          {
            isActive = true;
            command = "${
              pkgs.writeShellApplication {

                name = "work-balance";
                runtimeInputs = with pkgs; [ curl ] ++ [ jq ];
                text = ''
                  result=$(curl \
                    --silent --retry 9 --retry-delay 60 --retry-connrefused --max-time 10 \
                    -u "$(cat ${config.sops.secrets."toggl".path}):api_token" -H "Content-Type: application/json" \
                    "https://api.track.toggl.com/api/v9/me/time_entries?start_date=2025-06-01&end_date=$(date -d tomorrow +%Y-%m-%d)" \
                  ) || result="unavailable"

                  daily=$(echo "$result" | jq '[.[].duration] | add / 3600 | round')           || daily=0
                  days=$(echo "$result"  | jq '[.[].start | split("T")[0]] | unique | length') || days=0
                  diff=$((daily - days * 8))

                  if [ "$result" = "unavailable" ]; then
                    echo "Toggl API unavailable"
                  else
                    echo "Work balance: $((diff))h"
                  fi
                '';
              }
            }/bin/work-balance";
            interval = 3600;
            uuid = "alarm";
          }
        ];
      };
      center-index = 10;

      left-active = false;
      left-commands-json = with lib.gvariant; [
        (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ])
      ];

      right-active = false;
      right-commands-json = with lib.gvariant; [
        (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ])
      ];

      click-on-output-active = false;
    };
  };

  # Secrets for toggle track
  sops.secrets."toggl" = {
    owner = config.users.users."user".name;
  };
}
