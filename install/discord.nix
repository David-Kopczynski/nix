{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ./../derivations/electron-wrapper {
      name = "discord";
      desktopName = "Discord";
      url = "https://discord.com/app";
      description = "All-in-one cross-platform voice and text chat for gamers";
      icon = pkgs.fetchurl {
        url = "https://github.com/github/explore/blob/main/topics/discord/discord.png";
        sha256 = "sha256-05Ln/r7NIBKLIQBlaCNo9EKRWvIMGdHkn0TISZAVKXw=";
      };
    })
  ];
}
