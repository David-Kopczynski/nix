{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ../derivations/electron-wrapper {
      name = "notion";
      desktopName = "Notion";
      url = "https://www.notion.so/";
      description = "App to write, plan, collaborate, and get organised";
      icon = pkgs.fetchurl {
        url = "https://github.com/github/explore/blob/main/topics/notion/notion.png";
        sha256 = "sha256-qWiOBbfCMYa5VpBqvTknhH1u0oEcaZm9d+QZSX1Fjrs=";
      };
    })
  ];
}
