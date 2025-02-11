{ config, lib, ... }:

lib.mkIf (config.system.name == "laptop") {
  services.printing.enable = true;
}
