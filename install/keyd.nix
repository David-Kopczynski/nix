{ config, lib, ... }:

lib.mkIf (config.system.name == "laptop") {
  services.keyd.enable = true;
  services.keyd.keyboards.default = {

    ids = [ "*" ];

    # Open terminal with FK12
    settings.main.media = "C-A-t";

    # Disable caps lock
    settings.main.capslock = "overload(caps, esc)";
    settings.caps = {

      # Special layer characters
      w = "pageup";
      a = "home";
      s = "pagedown";
      d = "end";

      "1" = "f1";
      "2" = "f2";
      "3" = "f3";
      "4" = "f4";
      "5" = "f5";
      "6" = "f6";
      "7" = "f7";
      "8" = "f8";
      "9" = "f9";
      "0" = "f10";
      minus = "f11";
      equal = "f12";
    };
  };
}
