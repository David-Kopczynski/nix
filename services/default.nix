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

    # { sort-start }
    openssh.enable = true;
    printing.enable = true;
    # { sort-end }

    # ---------- Languages ---------- #

    # { sort-start }
    # { sort-end }

    # ---------- Programs ---------- #

    # { sort-start }
    udev.packages = with pkgs; [ platformio-core openocd ];
    # { sort-end }

    # ---------- Games ---------- #

    # { sort-start }
    # { sort-end }
  };

  virtualisation = {

    # ---------- Tools ---------- #

    # { sort-start }
    docker.enable = true;
    # { sort-end }
  };

  # Potential settings that have to be set on user level
  users.users.user = {
    extraGroups = [

      # { sort-start }
      "dialout" # Serial port access with PlatformIO
      "docker" # Docker access
      # { sort-end }

    ];
  };
}
