{ config, ... }:

{
  home-manager.users."user".dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/background" = {
      picture-uri = "file://${../resources/gnome/wallpaper-bright.jpg}";
      picture-uri-dark = "file://${../resources/gnome/wallpaper-dark.jpg}";
    };
  };

  # Profile picture (workaround) and
  # inherit monitor layout to gdm
  system.activationScripts."profile-picture".text =
    let
      image = toString ../resources/gnome/profile-picture.png;
      monitor = toString /home/user/.config/monitors.xml;
    in
    ''
      if [ -f ${image} ]; then
        mkdir -p /var/lib/AccountsService/{icons,users}
        cp ${image} /var/lib/AccountsService/icons/user
        echo -e "[User]\nIcon=/var/lib/AccountsService/icons/user\n" > /var/lib/AccountsService/users/user

        chown root:root /var/lib/AccountsService/users/user
        chmod 0600 /var/lib/AccountsService/users/user

        chown root:root /var/lib/AccountsService/icons/user
        chmod 0444 /var/lib/AccountsService/icons/user
      fi

      if [ -f ${monitor} ]; then
        mkdir -p /run/gdm/.config
        cp ${monitor} /run/gdm/.config/
        chown gdm:gdm /run/gdm/.config/monitors.xml
        chmod 0644 /run/gdm/.config/monitors.xml
      fi
    '';

  # QT theme
  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";
}
