{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [ gnomeExtensions.easyeffects-preset-selector ] ++ [ easyeffects ];

  # Presets
  home-manager.users."user".xdg.configFile."easyeffects/output".source = pkgs.fetchFromGitHub {
    owner = "JackHack96";
    repo = "EasyEffects-Presets";
    rev = "master";
    sha256 = "sha256-nXVtX0ju+Ckauo0o30Y+sfNZ/wrx3HXNCK05z7dLaFc=";
  };

  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs; [ gnomeExtensions.easyeffects-preset-selector.extensionUuid ];
    };
  };
}
