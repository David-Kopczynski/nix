{ user }:

{
  home-manager.users.${user} = { pkgs, ... }: {

    programs.vscodium.enable = true;
    programs.vscodium = {

      # FHS for extensions
      package = pkgs.vscodium.fhsWithPackages (
        ps: with ps; [
          (openssh.overrideAttrs (prev: {
            patches = (prev.patches or [ ]) ++ [ ./openssh.patch ];
            doCheck = false;
          }))
        ]
      );

      profiles.default = {

        # General
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = true;

        userSettings = {

          # Git
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.suggestSmartCommit" = false;

          # Theming
          "window.autoDetectColorScheme" = true;
          "workbench.iconTheme" = "material-icon-theme";
        };

        keybindings = [

          # Basic keybindings
          {
            key = "ctrl+[Backslash]"; # ctrl+# with de
            command = "editor.action.commentLine";
            when = "editorTextFocus && !editorReadonly";
          }
        ];

        extensions =
          with pkgs.vscode-extensions;
          [
            # Environment
            arrterian.nix-env-selector

            # Tooling
            waderyan.gitblame
            streetsidesoftware.code-spell-checker
            streetsidesoftware.code-spell-checker-german

            # Theming
            pkief.material-icon-theme
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [

            # Theming (custom)
            {
              name = "vscode-pets";
              publisher = "tonybaloney";
              version = "1.35.0";
              sha256 = "sha256-TWWoJ0dBwEHnbi16d0/sBodqg9l92TIzxZYvXTjxNpY=";
            }
            {
              name = "watch-your-line";
              publisher = "davideliaschriskopczynski";
              version = "1.1.3";
              sha256 = "sha256-MhLl/Ftw/EdIbw5SYJPYoO90XfFaeAdc1TZf5bdKj6g=";
            }
          ];
      };
    };

    # Show application in quick launcher
    dconf.settings."org/gnome/shell".favorite-apps = [ "codium.desktop" ];
  };
}
