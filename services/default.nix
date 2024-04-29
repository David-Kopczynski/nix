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

    # ---------- System ---------- #
    openssh.enable = true;
    printing.enable = true;

    # ---------- Tools ---------- #

    # ---------- Programs ---------- #
    udev.packages = with pkgs; [ platformio-core openocd ];

    # ---------- Games ---------- #
  };

  virtualisation = {

    # ---------- Tools ---------- #
    docker.enable = true;
  };

  # Potential settings that have to be set on user level
  users.users.user = {
    extraGroups = [
      "dialout" # Serial port access with PlatformIO
      "docker" # Docker access
    ];
  };
}
