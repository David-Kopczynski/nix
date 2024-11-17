{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ./../derivations/electron-wrapper {
      name = "discord";
      desktopName = "Discord";
      url = "https://discord.com/app";
      description = "Discord wrapped in Electron";
      icon = ./../resources/discord/icon.png;
    })
  ];
}
