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
    ++ [ gnomeExtensions.just-perfection ]
    ++ [ gnomeExtensions.smile-complementary-extension smile ]
    ++ [ gnomeExtensions.user-themes-x ]
    ++ [ gnomeExtensions.x11-gestures ]
    # { sort-end }

    # ---------- Tools ---------- #

    # { sort-start }
    ++ [ ansible ansible-lint ]
    ++ [ bitwarden-cli libsecret ] # Install with `bw login --apikey`
    ++ [ btop ]
    ++ [ cloudflared ]
    ++ [ gh gh-copilot ] # Install with `gh auth login`
    ++ [ kubectl minikube ]
    ++ [ openconnect ]
    ++ [ texliveFull ]
    # { sort-end }

    # ---------- Languages ---------- #

    # { sort-start }
    ++ [ ghc hlint ]
    ++ [ nodejs ]
    ++ [ python3 ]
    ++ [ rustc cargo gcc rustfmt clippy ]
    # { sort-end }

    # ---------- Programs ---------- #

    # { sort-start }
    ++ [ anki-bin ]
    ++ [ blender ]
    ++ [ chromium ]
    ++ [ f3d ]
    ++ [ freecad ]
    ++ [ gimp darktable ]
    ++ [ godot_4 ]
    ++ [ inkscape ]
    ++ [ kicad-small ]
    ++ [ libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE ]
    ++ [ libsForQt5.kdenlive ]
    ++ [ mpv ]
    ++ [ obs-studio ]
    ++ [ postman ]
    ++ [ qemu quickemu virt-viewer ]
    ++ [ spotify ]
    ++ [ thunderbird ]
    ++ [ webex ]
    ++ [ zoom-us ]
    # { sort-end }

    # { sort-start }
    ++ [ unstable.prusa-slicer ]
    ++ [ unstable.vscode ]
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

  environment.variables = {

    # Rust tool setup with NixOS
    # See: https://nixos.wiki/wiki/Rust
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

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
      "i2c" # I2C access (for ddcutil)
      "input" # Access to input devices with Wootility
    ];
  };
}
