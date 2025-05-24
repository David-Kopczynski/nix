{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "laptop") {
  services.printing.enable = true;
}
// {
  # Remove gnome default application
  services.xserver.excludePackages = with pkgs; [ simple-scan ];
}
