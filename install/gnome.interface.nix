{ config, lib, ... }:

with lib.gvariant;
{
  home-manager.users.user.dconf = {
    inherit (config.programs.dconf) enable;

    # Modify clock format
    settings."org/gnome/desktop/interface" = {
      clock-show-seconds = false;
      clock-show-weekday = false;
      enable-animations = true;
    };

    # Add world clocks
    settings."org/gnome/clocks" = {
      world-clocks = [
        (mkDictionaryEntry "location" (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Coordinated Universal Time (UTC)"
            "@UTC"
            false
            (mkEmptyArray (type.tupleOf [ type.double type.double ]))
            (mkEmptyArray (type.tupleOf [ type.double type.double ]))
          ]))
        ])))
        (mkDictionaryEntry "location" (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Berlin"
            "EDDT"
            true
            [ (mkTuple [ 0.91746141594945008 0.23241968454167572 ]) ]
            [ (mkTuple [ 0.91658875132345297 0.23387411976724018 ]) ]
          ]))
        ])))
      ];
    };
    settings."org/gnome/shell/world-clocks" = {
      locations = [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Coordinated Universal Time (UTC)"
            "@UTC"
            false
            (mkEmptyArray (type.tupleOf [ type.double type.double ]))
            (mkEmptyArray (type.tupleOf [ type.double type.double ]))
          ]))
        ]))
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Berlin"
            "EDDT"
            true
            [ (mkTuple [ 0.91746141594945008 0.23241968454167572 ]) ]
            [ (mkTuple [ 0.91658875132345297 0.23387411976724018 ]) ]
          ]))
        ]))
      ];
    };

    # Add weather
    settings."org/gnome/Weather" = {
      locations = [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Aachen"
            "ETNG"
            false
            [ (mkTuple [ 0.88953614791754076 0.10559241974565695 ]) ]
            [ (mkTuple [ 0.88953614791754076 0.10559241974565695 ]) ]
          ]))
        ]))
      ];
    };
    settings."org/gnome/shell/weather" = {
      automatic-location = true;
      locations = [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Aachen"
            "ETNG"
            false
            [ (mkTuple [ 0.88953614791754076 0.10559241974565695 ]) ]
            [ (mkTuple [ 0.88953614791754076 0.10559241974565695 ]) ]
          ]))
        ]))
      ];
    };
  };
}

