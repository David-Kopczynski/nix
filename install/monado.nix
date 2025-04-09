{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.system.name == "workstation") {
  # Monado can be run with the following commands:
  # systemctl --user start monado.service
  # journalctl --user --follow --unit monado.service
  services.monado.enable = true;
  services.monado.defaultRuntime = true;

  programs.envision.enable = true;

  systemd.user.services."monado".environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };

  home-manager.users."user".xdg.configFile."openxr/1/active_runtime.json".source =
    "${with pkgs; monado}/share/openxr/1/openxr_monado.json";

  home-manager.users."user".xdg.configFile."openvr/openvrpaths.vrpath".text = builtins.toJSON {
    config = [ "${config.home-manager.users."user".xdg.dataHome}/Steam/config" ];
    external_drivers = null;
    jsonid = "vrpathreg";
    log = [ "${config.home-manager.users."user".xdg.dataHome}/Steam/logs" ];
    runtime = [ "${with pkgs; opencomposite}/lib/opencomposite" ];
    version = 1;
  };

  home-manager.users."user".home.file.".local/share/monado/hand-tracking-models".source =
    pkgs.fetchgit
      {
        url = "https://gitlab.freedesktop.org/monado/utilities/hand-tracking-models";
        sha256 = "x/X4HyyHdQUxn3CdMbWj5cfLvV7UyQe1D01H93UCk+M=";
        fetchLFS = true;
      };

  # Steam related settings
  # LAUNCH OPTIONS: "env PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc %command%"
  hardware.steam-hardware.enable = true;

  security.wrappers."vrcompositor" = {
    owner = config.users.users."user".name;
    group = "users";
    source = /home/user/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher;
    capabilities = "CAP_SYS_NICE+ep";
  };
}
