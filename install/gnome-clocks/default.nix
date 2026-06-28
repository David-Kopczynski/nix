{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnome-clocks ];

  programs.dconf.profiles."user".databases =
    let
      clocks = [
        ({ name = "Anywhere on Earth (AoE)"; } // { tag = "@AoE"; })
        ({ name = "Coordinated Universal Time (UTC)"; } // { tag = "@UTC"; })
      ];
    in
    [
      {
        # Enable common clocks for all users
        lockAll = true;
        settings."org/gnome/shell/world-clocks".locations =
          with lib.gvariant;
          mkArray (
            map (
              n:
              mkVariant (mkTuple [
                (mkUint32 2)
                (mkVariant (mkTuple [
                  n.name
                  n.tag
                  false
                  (mkEmptyArray (type.tupleOf ([ type.double ] ++ [ type.double ])))
                  (mkEmptyArray (type.tupleOf ([ type.double ] ++ [ type.double ])))
                ]))
              ])
            ) clocks
          );
      }
    ];
}
