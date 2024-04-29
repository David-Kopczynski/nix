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
  environment.systemPackages = with pkgs; [

    # ---------- Nix ---------- #
    nil
    nixpkgs-fmt

    # ---------- System ---------- #
    wget
    powertop

    # ---------- Tools ---------- #
    python3
    ghc
    texliveFull
    openconnect
    nodejs
    bitwarden-cli # Install with `bw login`
    ddcutil

    # ---------- Gnome ---------- #
    gnomeExtensions.clipboard-history
    gnomeExtensions.noannoyance-fork
    gnomeExtensions.smile-complementary-extension
    gnomeExtensions.color-picker
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.executor

    # ---------- Programs ---------- #
    spotify
    pdfarranger
    thunderbird
    libreoffice
    gimp
    mpv
    kicad
    anki-bin
    soundux
    ungoogled-chromium
    obs-studio
    prusa-slicer
    qemu

    unstable.smile # Currently only available in unstable
    unstable.webex
    unstable.vscode
    unstable.discord
    unstable.wootility

    # ---------- Games ---------- #
    # see https://www.protondb.com/ for compatibility
    unstable.prismlauncher
    unstable.heroic
    unstable.lutris
    unstable.r2modman
  ]
  ++ [ hlint ] # ghc (Haskell linter)
  ++ [ hunspell hunspellDicts.en_US hunspellDicts.de_DE ] # libreoffice (spell checking)
  ++ [ darktable ] # gimp (extended image type support)
  ++ [ quickemu virt-viewer ] # qemu (GUI for qemu)
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
