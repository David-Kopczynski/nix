{ ... }:

{
  fileSystems."/home/user/.local/share/Steam/steamapps" = {

    device = "/data/games/steam";
    fsType = "none";
    options = [ "bind" ] ++ [ "nofail" ];
  };
}
