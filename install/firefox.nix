{ pkgs, ... }:

{
  programs.firefox.enable = true;

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ gnome.epiphany ];
}
