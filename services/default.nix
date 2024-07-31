{ config, pkgs, ... }:

{
  # Host specific configuration
  imports = [
    ./hosts/laptop.nix
    ./hosts/workstation.nix
  ];

  # Services started with possible configuration
  # Options can be found in https://search.nixos.org/options
  services = {

    # ---------- Tools ---------- #

    openssh.enable = true;
    printing.enable = true;
    touchegg.enable = true;

    # ---------- Languages ---------- #

    # ---------- Programs ---------- #

    udev.packages = with pkgs; [ platformio-core openocd ];

    # ---------- Games ---------- #
  };

  virtualisation = {
    # ---------- Tools ---------- #

    docker.enable = true;
    docker.liveRestore = false;
  };

  # Potential settings that have to be set on user level
  users.users.user = {
    extraGroups = [
      "dialout" # Serial port access with PlatformIO
      "docker" # Docker access
    ];
  };
}
