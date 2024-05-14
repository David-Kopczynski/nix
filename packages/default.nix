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

    # { sort-start }
    ++ [ nil nixpkgs-fmt ]
    # { sort-end }

    # ---------- Gnome ---------- #

    # { sort-start }
    ++ [ gnomeExtensions.brightness-control-using-ddcutil ddcutil ]
    ++ [ gnomeExtensions.color-picker ]
    ++ [ gnomeExtensions.executor ]
    ++ [ gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher ]
    ++ [ gnomeExtensions.noannoyance-fork ]
    ++ [ gnomeExtensions.smile-complementary-extension unstable.smile ] # Currently only available in unstable
    # { sort-end }

    # ---------- Tools ---------- #

    # { sort-start }
    ++ [ bitwarden-cli ] # Install with `bw login`
    ++ [ openconnect ]
    ++ [ texliveFull ]
    # { sort-end }

    # ---------- Languages ---------- #

    # { sort-start }
    ++ [ ghc hlint ]
    ++ [ nodejs ]
    ++ [ python3 ]
    # { sort-end }

    # ---------- Programs ---------- #

    # { sort-start }
    ++ [ soundux ]
    ++ [ unstable.anki-bin ]
    ++ [ unstable.discord ]
    ++ [ unstable.gimp unstable.darktable ]
    ++ [ unstable.kicad ]
    ++ [ unstable.libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE ]
    ++ [ unstable.mpv ]
    ++ [ unstable.obs-studio ]
    ++ [ unstable.pdfarranger ]
    ++ [ unstable.prusa-slicer ]
    ++ [ unstable.qemu unstable.quickemu unstable.virt-viewer ]
    ++ [ unstable.spotify ]
    ++ [ unstable.thunderbird ]
    ++ [ unstable.ungoogled-chromium ]
    ++ [ unstable.vscode ]
    ++ [ unstable.webex ]
    ++ [ unstable.wootility ]
    # { sort-end }

    # ---------- Games ---------- #
    # see https://www.protondb.com/ for compatibility

    # { sort-start }
    ++ [ unstable.heroic ]
    ++ [ unstable.lutris ]
    ++ [ unstable.prismlauncher ]
    ++ [ unstable.r2modman ]
    # { sort-end }

    ++ [ ];

  # Remove packages that are installed another way
  # see https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.gnome-tour # tour of GNOME

    epiphany # web browser
    geary # email client
    gnome-characters # character browser
    pkgs.gnome-text-editor # text editor
    totem # video player
    yelp # help browser
  ];

  # Potential settings that have to be set on user level
  users.users.user = {
    extraGroups = [

      # { sort-start }
      "i2c" # I2C access (for ddcutil)
      "input" # Access to input devices with Wootility
      # { sort-end }

    ];
  };
}
