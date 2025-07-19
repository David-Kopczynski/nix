{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ../derivations/electron-wrapper {
      name = "notion";
      desktopName = "Notion";
      url = "https://www.notion.so/";
      description = "App to write, plan, collaborate, and get organised";
      icon = builtins.fetchurl {
        name = "notion.png";
        url = "https://github.com/github/explore/blob/main/topics/notion/notion.png?raw=true";
      };
    })
  ];
}
