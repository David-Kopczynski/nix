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

                name = "executor-alarm";
                runtimeInputs = with pkgs; [ curl ];
                text = ''
                  result=$(curl \
                    --retry 9 --retry-delay 60 --retry-connrefused --max-time 10 \
                    -H "Authorization: Bearer $(cat ${config.sops.secrets."homeassistant".path})" \
                    -H "Content-Type: application/json" https://home.davidkopczynski.com/api/states/sensor.david_handy_next_alarm \
                  | grep -Po '"state":"\K[^"]*') || result="unavailable"

                  alarm=$(date -d "$result" +%s) || alarm=0
                  current=$(date +%s)
                  diff=$((alarm - current))

                  if [ "$result" = "unavailable" ] || [ 0 -gt $diff ]; then
                    echo "No Alarm Set"
                  else
                    hours=$((diff / 3600))
                    minutes=$(((diff % 3600) / 60))
                    output="Alarm in"

                    if   [ $minutes -lt 5 ];  then                       minutes=0; output="$output About"
                    elif [ $minutes -gt 55 ]; then hours=$((hours + 1)); minutes=0; output="$output About"
                    elif [ $minutes -ge 40 ]; then hours=$((hours + 1)); minutes=0; output="$output Nearly"
                    elif [ $minutes -le 20 ]; then                       minutes=0; output="$output Just Over"
                    fi
                    if   [ $hours -gt 0 ] && [ $minutes -ne 0 ]; then               output="$output $hours and a Half Hours"
                    elif [ $minutes -ne 0 ];                     then               output="$output Half an Hour"
                    elif [ $hours -gt 1 ];                       then               output="$output $hours Hours"
                    elif [ $hours -gt 0 ];                       then               output="$output 1 Hour"
                    else                                                            output="Alarm Soon"
                    fi

                    echo "$output"
                  fi
                '';
              }
            }/bin/executor-alarm";
            interval = 600;
            uuid = "alarm";
          }
        ];
      };
      center-index = 10;

      left-active = true;
      left-commands-json = builtins.toJSON {
        commands = [
          {
            isActive = true;
            command = "${
              pkgs.writeShellApplication {

                name = "executor-ppm";
                runtimeInputs = with pkgs; [ curl ];
                text = ''
                  result=$(curl \
                    --retry 4 --retry-delay 60 --retry-connrefused --max-time 10 \
                    -H "Authorization: Bearer $(cat ${config.sops.secrets."homeassistant".path})" \
                    -H "Content-Type: application/json" https://home.davidkopczynski.com/api/states/sensor.esphome_co2_david_co2_gehalt_david \
                  | grep -Po '"state":"\K[^"]*') || result="unavailable"

                  if [ "$result" = "unavailable" ]; then
                    echo "HomeAssistant Offline"
                  else
                    echo "$result ppm"
                  fi
                '';
              }
            }/bin/executor-ppm";
            interval = 300;
            uuid = "ppm";
          }
        ];
      };
      left-index = 10;

      right-active = false;
      right-commands-json = with lib.gvariant; [
        (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ])
      ];

      click-on-output-active = false;
    };
  };

  # Secrets for homeassistant
  sops.secrets."homeassistant" = {
    owner = config.users.users."user".name;
  };
}
