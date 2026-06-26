{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot = {

    # General
    editor = false;
    configurationLimit = 16;
    consoleMode = "max";
  };
}
