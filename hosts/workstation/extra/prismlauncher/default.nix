{ ... }:

{
  fileSystems."/home/user/.local/share/PrismLauncher/instances" = {

    device = "/data/games/prism";
    fsType = "none";
    options = [ "bind" ] ++ [ "nofail" ];
  };
}
