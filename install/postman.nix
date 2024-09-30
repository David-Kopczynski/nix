{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ postman ];
}
