{ config, pkgs, ... }:

let
  # Allow unstable packages
  unstable = import
    (builtins.fetchGit {
      name = "nixpkgs-unstable";
      url = "https://github.com/nixos/nixpkgs/";
      ref = "nixos-unstable";
    })
    { config = { allowUnfree = true; }; };
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List of packages installed in system scope
  # Packages can be found in https://search.nixos.org/packages
  # or with `nix search <package>`
  environment.systemPackages = with pkgs; [ ]

    # ---------- Nix ---------- #
    ++ [ nil nixpkgs-fmt ]

    # ---------- System ---------- #
    ++ [ powertop ]
    ++ [ wget ]

    # ---------- Gnome ---------- #
    ++ [ gnomeExtensions.brightness-control-using-ddcutil ]
    ++ [ gnomeExtensions.clipboard-history ]
    ++ [ gnomeExtensions.color-picker ]
    ++ [ gnomeExtensions.executor ]
    ++ [ gnomeExtensions.noannoyance-fork ]
    ++ [ gnomeExtensions.smile-complementary-extension ]

    # ---------- Tools ---------- #
    ++ [ bitwarden-cli ] # Install with `bw login`
    ++ [ ddcutil ]
    ++ [ openconnect ]
    ++ [ texliveFull ]

    # ---------- Languages ---------- #
    ++ [ ghc hlint ]
    ++ [ nodejs ]
    ++ [ python3 ]

    # ---------- Programs ---------- #
    ++ [ anki-bin ]
    ++ [ gimp darktable ]
    ++ [ kicad ]
    ++ [ libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE ]
    ++ [ mpv ]
    ++ [ obs-studio ]
    ++ [ pdfarranger ]
    ++ [ prusa-slicer ]
    ++ [ qemu quickemu virt-viewer ]
    ++ [ soundux ]
    ++ [ spotify ]
    ++ [ thunderbird ]
    ++ [ ungoogled-chromium ]

    ++ [ unstable.discord ]
    ++ [ unstable.smile ] # Currently only available in unstable
    ++ [ unstable.vscode ]
    ++ [ unstable.webex ]
    ++ [ unstable.wootility ]

    # ---------- Games ---------- #
    # see https://www.protondb.com/ for compatibility
    ++ [ unstable.heroic ]
    ++ [ unstable.lutris ]
    ++ [ unstable.prismlauncher ]
    ++ [ unstable.r2modman ]

    ++ [ ];

  # Remove packages that are installed another way
  # see https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.gnome-tour # tour of GNOME

    yelp # help browser
    epiphany # web browser
    pkgs.gnome-text-editor # text editor
    gnome-characters # character browser
    geary # email client
    totem # video player
  ];

  # Potential settings that have to be set on user level
  users.users.user = {
    extraGroups = [
      "input" # Access to input devices with Wootility
      "i2c" # I2C access (for ddcutil)
    ];
  };
}
