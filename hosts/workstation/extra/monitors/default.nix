{ config, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ ${config.home-manager.users."user".xdg.configHome}/monitors.xml - - - - ${./monitors.xml}"
  ];
}
