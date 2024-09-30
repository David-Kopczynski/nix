{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [ prismlauncher ];
}
