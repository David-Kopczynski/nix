{
  config,
  lib,
  pkgs,
  ...
}:

# https://lvra.gitlab.io/docs/fossvr/envision/
# build failure...
lib.mkIf (config.system.name == "workstation") {
  programs.envision.enable = true;
  programs.envision.openFirewall = false;
  programs.envision.package =
    with pkgs.unstable;
    envision.override {
      inherit envision;
      inherit envision-unwrapped;
    };

  hardware.graphics.extraPackages = with pkgs; [ monado-vulkan-layers ];
}
