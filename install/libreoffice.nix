{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ libreoffice hunspell hunspellDicts.en_US hunspellDicts.de_DE ];
}
