{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ./../derivations/electron-wrapper {
      name = "discord";
      desktopName = "Discord";
      url = "https://discord.com/app";
      description = "All-in-one cross-platform voice and text chat for gamers";
      icon = builtins.fetchurl {
        name = "discord.png";
        url = "https://github.com/github/explore/blob/main/topics/discord/discord.png?raw=true";
      };
    })
  ];
}
