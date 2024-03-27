{ config, pkgs, lib, ... }:

lib.mkIf (config.host == "laptop") {

}
