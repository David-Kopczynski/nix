{ config, ... }:

{
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/background" = {
      picture-uri = "file://${../resources/gnome/wallpaper-bright.jpg}";
      picture-uri-dark = "file://${../resources/gnome/wallpaper-dark.jpg}";
    };
  };

  # Profile picture (workaround)
  system.activationScripts."profile-picture".text =
    let
      image = ../resources/gnome/profile-picture.png;
    in
    ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp ${image} /var/lib/AccountsService/icons/user
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/user\n" > /var/lib/AccountsService/users/user

      chown root:root /var/lib/AccountsService/users/user
      chmod 0600 /var/lib/AccountsService/users/user

      chown root:root /var/lib/AccountsService/icons/user
      chmod 0444 /var/lib/AccountsService/icons/user
    '';

  # Inherit monitor layout to gdm
  system.activationScripts."monitor-layout".text =
    let
      monitor = builtins.toPath "${config.home-manager.users."user".xdg.configHome}/monitors.xml";
    in
    ''
      mkdir -p /run/gdm/.config
      cp ${monitor} /run/gdm/.config/

      chown gdm:gdm /run/gdm/.config/monitors.xml
      chmod 0644 /run/gdm/.config/monitors.xml
    '';

  # QT theme
  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";
}
