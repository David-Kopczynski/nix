{ config, lib, pkgs, ... }:

with lib.gvariant;
{
  environment.systemPackages = with pkgs.gnomeExtensions; [ executor ];

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [ executor.extensionUuid ];
    };

    # Custom settings
    settings."org/gnome/shell/extensions/executor" = {
      center-active = true;
      center-commands-json = "{\"commands\":[{\"isActive\":true,\"command\":\"result=\\\"$(curl -H \\\"Authorization: Bearer ***REMOVED***\\\" -H \\\"Content-Type: application/json\\\" https://home.davidkopczynski.com/api/states/sensor.david_handy_next_alarm | grep -Po '\\\"state\\\":\\\"\\\\K[^\\\"]*')\\\"; alarm=$(date -d \\\"$result\\\" +%s); current=$(date +%s); diff=$((alarm - current)); if [[ $result == \\\"unavailable\\\" ]] || [[ $result == \\\"\\\" ]] || [[ 0 -gt $diff ]]; then echo \\\"No Alarm Set\\\"; else hours=$((diff / 3600)); minutes=$(((diff % 3600) / 60)); printf -v minutes \\\"%02d\\\" $minutes; echo \\\"Alarm in $hours:$minutes Hours\\\"; fi\",\"interval\":60,\"uuid\":\"17d7605b-772d-4327-90f4-891ff0681e44\"}]}";
      center-index = 10;

      left-active = true;
      left-commands-json = "{\"commands\":[{\"isActive\":true,\"command\":\"result=\\\"$(curl -H \\\"Authorization: Bearer ***REMOVED***\\\" -H \\\"Content-Type: application/json\\\" https://home.davidkopczynski.com/api/states/sensor.esphome_web_a326a4_co2_gehalt_david | grep -Po '\\\"state\\\":\\\"\\\\K[^\\\"]*')\\\"; if [[ $result == \\\"unavailable\\\" ]] || [[ $result = \\\"\\\" ]]; then echo \\\"HomeAssistant Offline\\\"; else echo \\\"$result ppm\\\"; fi\",\"interval\":60,\"uuid\":\"e318deb6-ed31-46ca-a273-3a74a862e1e3\"}]}";
      left-index = 10;

      right-active = false;
      right-commands-json = [ (mkDictionaryEntry "commands" [ (mkEmptyArray (type.dictionaryEntryOf type.string type.string)) ]) ];

      click-on-output-active = false;
    };
  };
}
