{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable.gnomeExtensions; [ alttab-scroll-workaround ];

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.unstable.gnomeExtensions; [ alttab-scroll-workaround.extensionUuid ];
    };
  };
}
