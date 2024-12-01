{ config, ... }:

{
  home-manager.users.${config.user}.dconf = {
    inherit (config.programs.dconf) enable;

    settings."org/gnome/desktop/background" = {
      picture-uri = "file://${config.root}/resources/gnome/wallpaper-bright.jpg";
      picture-uri-dark = "file://${config.root}/resources/gnome/wallpaper-dark.jpg";
    };
  };

  # Profile picture (workaround) and
  # inherit monitor layout to gdm
  system.activationScripts.script.text = ''
    mkdir -p /var/lib/AccountsService/{icons,users}
    cp ${config.root}/resources/gnome/profile-picture.png /var/lib/AccountsService/icons/user
    echo -e "[User]\nIcon=/var/lib/AccountsService/icons/user\n" > /var/lib/AccountsService/users/user

    chown root:root /var/lib/AccountsService/users/user
    chmod 0600 /var/lib/AccountsService/users/user

    chown root:root /var/lib/AccountsService/icons/user
    chmod 0444 /var/lib/AccountsService/icons/user

    if [ -f /home/user/.config/monitors.xml ]; then
      mkdir -p /run/gdm/.config
      cp /home/user/.config/monitors.xml /run/gdm/.config/
      chown gdm:gdm /run/gdm/.config/monitors.xml
      chmod 0644 /run/gdm/.config/monitors.xml
    fi
  '';

  # QT theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
