{ ... }:

{
  fileSystems."/home/user/Games" = {

    device = "/data/games/lutris";
    fsType = "none";
    options = [ "bind" ] ++ [ "nofail" ] ++ [ "x-gvfs-hide" ];
  };
}
