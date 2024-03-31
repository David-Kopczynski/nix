{ config, pkgs, ... }:

{
    # Fetch hardware config from nixos-hardware
    imports = [
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/pc"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/pc/ssd"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/gpu/nvidia"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/cpu/intel/cpu-only.nix"
    ];

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "user";

    # Hardware supported
    hardware.bluetooth.enable = true;
    hardware.wooting.enable = true;

    # Graphic card drivers
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # GPU drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Fix low refresh rate on high refresh rate monitors
    services.xserver.displayManager.setupCommands = ''
        KWIN_X11_REFRESH_RATE=165000
        KWIN_X11_NO_SYNC_TO_VBLANK=1
        KWIN_X11_FORCE_SOFTWARE_VSYNC=1
    '';
}
