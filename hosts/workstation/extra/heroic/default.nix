{ ... }:

{
  fileSystems."/home/user/Games/Heroic" = {

    device = "/data/games/heroic";
    fsType = "none";
    options = [ "bind" ] ++ [ "nofail" ] ++ [ "x-gvfs-hide" ];
  };
}
