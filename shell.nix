{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {

  XRT_COMPOSITOR_LOG = "debug";
  XRT_PRINT_OPTIONS = "on";
  IPC_EXIT_ON_DISCONNECT = "off";
  VIT_SYSTEM_LIBRARY_PATH = "${with pkgs; basalt-monado}/lib/libbasalt.so";
  STEAMVR_LH_ENABLE = "1";
  XRT_COMPOSITOR_COMPUTE = "1";
  WMR_HANDTRACKING = "0"; # "1"?

  XRT_DEBUG_GUI = "1"; # if lower basalt-xr is removed: manually press button "sumbit to SLAM"!
  # SLAM_UI = "1";
  RIFT_S_LOG = "1";

  # # ?: https://github.com/CIFASIS/basalt-xr
  # EUROC_HMD = false;
  # EUROC_PLAY_FROM_START = true;
  # SLAM_CONFIG = "${with pkgs; basalt-monado}/share/basalt/msdmi.toml";
  # SLAM_SUBMIT_FROM_START = true;

  shellHook = ''
    monado-service
    exit 0
  '';

  # Test with: nix-shell -p openxr-loader --run "hello_xr -g Vulkan"
}
