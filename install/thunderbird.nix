{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ thunderbird ];

  # Remove gnome default application
  environment.gnome.excludePackages = with pkgs; [ geary ];
}
