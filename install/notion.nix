{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ../derivations/electron-wrapper {
      name = "notion";
      desktopName = "Notion";
      url = "https://www.notion.so/";
      description = "Notion note taking app wrapped in Electron";
      icon = ../resources/notion/icon.png;
    })
  ];
}
