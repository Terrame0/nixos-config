{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    mutableExtensionsDir = false;
    profiles.default = {
      # -- vscode extensions
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        jnoortheen.nix-ide
        charliermarsh.ruff
        mads-hartmann.bash-ide-vscode
        llvm-vs-code-extensions.vscode-clangd
        ecmel.vscode-html-css
      ];
      # -- settings.json
      userSettings = {
        # -- misc tweaks
        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.untrustedFiles" = "open";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "telemetry.telemetryLevel" = "off";
        "chat.disableAIFeatures" = true;

        # -- nix linting
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "alejandra";
        "nix.serverPath" = "nixd";
        "nix.hiddenLanguageServerErrors" = ["textDocument/definition"];

        # -- default terminal emulator
        "terminal.external.linuxExec" = "alacritty";

        # -- disable updates
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;

        # -- cursor appearance
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorBlinking" = "solid";
        "editor.cursorStyle" = "line";

        # -- general appearance
        "workbench.tree.indent" = 20;
        "editor.minimap.enabled" = false;
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "workbench.colorTheme" = "Default Dark Modern";
        "workbench.iconTheme" = "vs-seti";

        # -- theming
        # foreground = "#c5c8c6"
        # background = "#1d1f21"
        # selection = "#373b41"
        # line = "#282a2e"
        # comment = "#969896"
        # red = "#d54e53"
        # orange = "#e78c45"
        # yellow = "#e7c547"
        # green = "#b9ca4a"
        # aqua = "#70c0b1"
        # blue = "#7aa6da"
        # purple = "#c397d8"
        # window = "#4d5057"

        "workbench.colorCustomizations" = {
          "editor.background" = "#1d1f21";
          "editor.foreground" = "#c5c8c6";

          "editor.selectionBackground" = "#373b41";
          "editor.lineHighlightBackground" = "#282a2e";

          "editorCursor.foreground" = "#c5c8c6";

          "editorLineNumber.foreground" = "#4d5057";
          "editorLineNumber.activeForeground" = "#c5c8c6";
        };

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            # Comments
            {
              scope = "comment";
              settings = {
                foreground = "#969896";
              };
            }

            # Strings
            {
              scope = "string";
              settings = {
                foreground = "#b9ca4a";
              };
            }

            # Keywords / control flow
            {
              scope = "keyword";
              settings = {
                foreground = "#c397d8";
              };
            }

            # Function names
            {
              scope = "entity.name.function";
              settings = {
                foreground = "#7aa6da";
              };
            }

            # Types, classes, structs
            {
              scope = "entity.name.type";
              settings = {
                foreground = "#e7c547";
              };
            }

            # Constants / builtins
            {
              scope = [
                "constant.language"
                "support.constant"
              ];
              settings = {
                foreground = "#e7c547";
              };
            }

            # Numbers
            {
              scope = "constant.numeric";
              settings = {
                foreground = "#e78c45";
              };
            }

            # Variables (keep neutral, kill rainbow)
            {
              scope = "variable";
              settings = {
                foreground = "#c5c8c6";
              };
            }
          ];
        };
      };
    };
  };
}
