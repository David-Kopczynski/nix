{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkMerge [
  (lib.mkIf (config.system.name == "laptop") {
    services.printing.enable = true;
  })
  {
    # Remove gnome default application
    environment.gnome.excludePackages = with pkgs; [ simple-scan ];
  }
]
