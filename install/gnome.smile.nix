{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.smile-complementary-extension
    smile
  ];

  # Remove default gnome applications
  environment.gnome.excludePackages = with pkgs.gnome; [ gnome-characters ];

  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Enable extension
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [ smile-complementary-extension.extensionUuid ];
    };

    settings."it/mijorus/smile" = {
      is-first-run = false;
    };

    # Add custom keybinding
    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-smile/"
      ];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-smile" = {
      name = "smile";
      command = "smile";
      binding = "<Shift><Control>comma";
    };
  };
}
