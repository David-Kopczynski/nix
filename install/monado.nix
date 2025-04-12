{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  # Monado can be run with the following commands:
  #   systemctl --user start monado.service
  #   systemctl --user stop monado.{service,socket}
  #   journalctl --user --follow --unit monado.service
  # Games require LAUNCH OPTIONS: "env PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc %command%"
  services.monado.enable = true;
  services.monado.defaultRuntime = true;
  services.monado.package =
    with pkgs;
    monado.overrideAttrs (
      finalAttrs: previousAttrs: {
        src = fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "thaytan";
          repo = "monado";
          rev = "dev-constellation-controller-tracking";
          hash = "sha256-o9JI2vCuDHEI6MNIWjbw7HGUBsnRQo58AUtDw1XUgw8=";
        };

        patches = [ ];
      }
    );

  systemd.user.services."monado".environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";

    # Enable debugging if needed
    XRT_DEBUG_GUI = "0";
  };

  # OpenXR discovery
  home-manager.users."user".xdg.configFile."openxr/1/active_runtime.json".source =
    "${config.services.monado.package}/share/openxr/1/openxr_monado.json";

  home-manager.users."user".xdg.configFile."openvr/openvrpaths.vrpath".text = builtins.toJSON {
    config = [ "${config.home-manager.users."user".xdg.dataHome}/Steam/config" ];
    external_drivers = null;
    jsonid = "vrpathreg";
    log = [ "${config.home-manager.users."user".xdg.dataHome}/Steam/logs" ];
    runtime = [ "${with pkgs; opencomposite}/lib/opencomposite" ];
    version = 1;
  };

  # Hand tracking models (otherwise monado will crash)
  home-manager.users."user".home.file.".local/share/monado/hand-tracking-models".source =
    pkgs.fetchgit
      {
        url = "https://gitlab.freedesktop.org/monado/utilities/hand-tracking-models";
        sha256 = "sha256-x/X4HyyHdQUxn3CdMbWj5cfLvV7UyQe1D01H93UCk+M=";
        fetchLFS = true;
      };
}
