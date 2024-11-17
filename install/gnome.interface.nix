{ config, lib, ... }:

{
  home-manager.users.user.dconf = with lib.gvariant; {
    inherit (config.programs.dconf) enable;

    # Main applications
    settings."org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "firefox.desktop"
        "spotify.desktop"
        "org.gnome.Console.desktop"
      ];

      app-picker-layout = [
        # Page 1: General tools and utilities
        (lib.lists.imap0
          (
            i: name:
            (mkDictionaryEntry name (mkVariant [ (mkDictionaryEntry "position" (mkVariant (mkUint32 i))) ]))
          )
          [
            "nixos-manual.desktop"
            "org.gnome.Settings.desktop"
            "org.remmina.Remmina.desktop"
            "remote-viewer.desktop"
            "org.gnome.SystemMonitor.desktop"
            "gnome"
            "btop.desktop"
            "nvim.desktop"
            "chromium-browser.desktop"
            "postman.desktop"
            "it.mijorus.smile.desktop"
            "anki.desktop"
          ]
        )

        # Page 2: Creative tools
        (lib.lists.imap0
          (
            i: name:
            (mkDictionaryEntry name (mkVariant [ (mkDictionaryEntry "position" (mkVariant (mkUint32 i))) ]))
          )
          [
            "gimp.desktop"
            "org.darktable.darktable.desktop"
            "org.inkscape.Inkscape.desktop"
            "org.freecadweb.FreeCAD.desktop"
            "kicad"
            "blender.desktop"
            "f3d.desktop"
            "org.godotengine.Godot4.desktop"
            "PrusaSlicer.desktop"
            "PrusaGcodeviewer.desktop"
            "mpv.desktop"
            "com.obsproject.Studio.desktop"
            "org.kde.kdenlive.desktop"
          ]
        )

        # Page 3: Office
        (lib.lists.imap0
          (
            i: name:
            (mkDictionaryEntry name (mkVariant [ (mkDictionaryEntry "position" (mkVariant (mkUint32 i))) ]))
          )
          [
            "thunderbird.desktop"
            "notion.desktop"
            "Zoom.desktop"
            "simple-scan.desktop"
            "cups.desktop"
            "libre"
            "com.governikus.ausweisapp2.desktop"
          ]
        )

        # Page 4: Games
        (lib.lists.imap0
          (
            i: name:
            (mkDictionaryEntry name (mkVariant [ (mkDictionaryEntry "position" (mkVariant (mkUint32 i))) ]))
          )
          [
            "nvidia-settings.desktop"

            "wootility-lekker.desktop"
            "discord.desktop"
            "steam.desktop"
            "com.heroicgameslauncher.hgl.desktop"
            "net.lutris.Lutris.desktop"
            "org.prismlauncher.PrismLauncher.desktop"
            "r2modman.desktop"
          ]
        )
      ];
    };

    # Custom folders
    settings."org/gnome/desktop/app-folders" = {
      folder-children = [
        "gnome"
        "kicad"
        "libre"
      ];
    };

    settings."org/gnome/desktop/app-folders/folders/gnome" = {
      name = "GNOME";
      apps = [
        "org.gnome.Contacts.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Weather.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.Maps.desktop"
        "org.gnome.Snapshot.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.Music.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Extensions.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Logs.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.seahorse.Application.desktop"
      ];
    };
    settings."org/gnome/desktop/app-folders/folders/kicad" = {
      name = "KiCad";
      apps = [
        "org.kicad.kicad.desktop"
        "org.kicad.gerbview.desktop"
        "org.kicad.bitmap2component.desktop"
        "org.kicad.pcbcalculator.desktop"
        "org.kicad.pcbnew.desktop"
        "org.kicad.eeschema.desktop"
      ];
    };
    settings."org/gnome/desktop/app-folders/folders/libre" = {
      name = "LibreOffice";
      apps = [
        "startcenter.desktop"
        "base.desktop"
        "calc.desktop"
        "draw.desktop"
        "impress.desktop"
        "math.desktop"
        "writer.desktop"
      ];
    };

    # Modify top bar format
    settings."org/gnome/desktop/interface" = {
      clock-show-seconds = false;
      clock-show-weekday = false;
      enable-animations = true;
      show-battery-percentage = true;
    };

    # Add world clocks
    settings."org/gnome/clocks" = {
      world-clocks = [
        ([
          (mkDictionaryEntry "location" (
            mkVariant (mkTuple [
              (mkUint32 2)
              (mkVariant (mkTuple [
                "Coordinated Universal Time (UTC)"
                "@UTC"
                false
                (mkEmptyArray (
                  type.tupleOf [
                    type.double
                    type.double
                  ]
                ))
                (mkEmptyArray (
                  type.tupleOf [
                    type.double
                    type.double
                  ]
                ))
              ]))
            ])
          ))
        ])
        ([
          (mkDictionaryEntry "location" (
            mkVariant (mkTuple [
              (mkUint32 2)
              (mkVariant (mkTuple [
                "Berlin"
                "EDDT"
                true
                [
                  (mkTuple [
                    0.9174614159494501
                    0.23241968454167572
                  ])
                ]
                [
                  (mkTuple [
                    0.916588751323453
                    0.23387411976724018
                  ])
                ]
              ]))
            ])
          ))
        ])
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
            (mkEmptyArray (
              type.tupleOf [
                type.double
                type.double
              ]
            ))
            (mkEmptyArray (
              type.tupleOf [
                type.double
                type.double
              ]
            ))
          ]))
        ]))
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Berlin"
            "EDDT"
            true
            [
              (mkTuple [
                0.9174614159494501
                0.23241968454167572
              ])
            ]
            [
              (mkTuple [
                0.916588751323453
                0.23387411976724018
              ])
            ]
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
            [
              (mkTuple [
                0.8895361479175408
                0.10559241974565695
              ])
            ]
            [
              (mkTuple [
                0.8895361479175408
                0.10559241974565695
              ])
            ]
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
            [
              (mkTuple [
                0.8895361479175408
                0.10559241974565695
              ])
            ]
            [
              (mkTuple [
                0.8895361479175408
                0.10559241974565695
              ])
            ]
          ]))
        ]))
      ];
    };

    # Formats and units
    settings."system/locale" = {
      region = "de_DE.UTF-8";
    };
  };
}
