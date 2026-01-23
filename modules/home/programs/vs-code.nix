{pkgs, ...}: let
  colors = {
    foreground = "#c5c8c6";
    background = "#1d1f21";
    selection = "#373b41";
    line = "#282a2e";
    comment = "#969896";

    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";

    window = "#4d5057";
  };
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    mutableExtensionsDir = false;

    profiles.default = {
      # -- extensions
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
        # -- misc
        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.untrustedFiles" = "open";
        "telemetry.telemetryLevel" = "off";
        "chat.disableAIFeatures" = true;

        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;

        # -- updates
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;

        # -- nix
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "alejandra";
        "nix.serverPath" = "nixd";
        "nix.hiddenLanguageServerErrors" = ["textDocument/definition"];

        # -- fonts & cursor
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;

        "editor.cursorStyle" = "line";
        "editor.cursorBlinking" = "solid";
        "editor.cursorSmoothCaretAnimation" = "on";

        # -- editor layout
        "editor.minimap.enabled" = false;
        "workbench.tree.indent" = 20;

        "workbench.colorTheme" = "Default Dark Modern";
        "workbench.iconTheme" = "vs-seti";

        # ============================================================
        # -- ui theming
        # ============================================================

        "workbench.colorCustomizations" = {
          # -- core editor
          "editor.background" = colors.background;
          "editor.foreground" = colors.foreground;

          "editor.selectionBackground" = colors.selection;
          "editor.lineHighlightBackground" = colors.line;

          "editorCursor.foreground" = colors.foreground;

          "editorLineNumber.foreground" = colors.window;
          "editorLineNumber.activeForeground" = colors.foreground;

          # -- focus & borders
          "focusBorder" = colors.blue;
          "contrastBorder" = colors.line;

          # -- sidebar / activity / status
          "sideBar.background" = colors.background;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.line;

          "activityBar.background" = colors.background;
          "activityBar.foreground" = colors.foreground;
          "activityBar.inactiveForeground" = colors.comment;
          "activityBar.border" = colors.line;

          "statusBar.background" = colors.background;
          "statusBar.foreground" = colors.foreground;
          "statusBar.border" = colors.line;

          # -- panels
          "panel.background" = colors.background;
          "panel.border" = colors.line;
          "panelTitle.activeForeground" = colors.foreground;
          "panelTitle.inactiveForeground" = colors.comment;

          # -- tabs
          "tab.activeBackground" = colors.selection;
          "tab.activeForeground" = colors.foreground;

          "tab.inactiveBackground" = colors.background;
          "tab.inactiveForeground" = colors.comment;

          "tab.border" = colors.line;

          # -- lists & trees
          "list.activeSelectionBackground" = colors.selection;
          "list.activeSelectionForeground" = colors.foreground;

          "list.inactiveSelectionBackground" = colors.line;
          "list.inactiveSelectionForeground" = colors.foreground;

          "list.hoverBackground" = colors.selection;
          "list.hoverForeground" = colors.foreground;

          "list.focusOutline" = colors.blue;
          "tree.indentGuidesStroke" = colors.line;

          # -- inputs
          "input.background" = colors.line;
          "input.foreground" = colors.foreground;
          "input.border" = colors.line;

          "dropdown.background" = colors.line;
          "dropdown.foreground" = colors.foreground;
          "dropdown.border" = colors.line;

          # -- scrollbar
          "scrollbarSlider.background" = colors.window;
          "scrollbarSlider.hoverBackground" = colors.comment;
          "scrollbarSlider.activeBackground" = colors.foreground;

          # -- git decorations
          "gitDecoration.modifiedResourceForeground" = colors.orange;
          "gitDecoration.addedResourceForeground" = colors.green;
          "gitDecoration.deletedResourceForeground" = colors.red;
          "gitDecoration.untrackedResourceForeground" = colors.comment;
          "gitDecoration.ignoredResourceForeground" = colors.selection;

          # -- diagnostics
          "editorError.foreground" = colors.red;
          "editorWarning.foreground" = colors.orange;
          "editorInfo.foreground" = colors.blue;
          "editorHint.foreground" = colors.comment;

          # -- search
          "editor.findMatchBackground" = colors.yellow;
          "editor.findMatchBorder" = colors.orange;
          "editor.findMatchHighlightBackground" = colors.orange;

          # -- welcome
          "welcomePage.background" = colors.background;
          "welcomePage.tileBackground" = colors.line;
          "welcomePage.tileHoverBackground" = colors.selection;
          "welcomePage.tileBorder" = colors.line;
          "welcomePage.tileShadow" = "#00000000";

          # -- debug
          "debugToolBar.background" = colors.line;
          "debugToolBar.border" = colors.line;

          # -- terminal
          "terminal.background" = colors.background;
          "terminal.foreground" = colors.foreground;
          "terminal.border" = colors.line;

          "terminalCursor.foreground" = colors.foreground;
          "terminal.selectionBackground" = colors.selection;

          "terminal.ansiBrightBlack" = colors.window;

          "terminal.integrated.colorPalette" = [
            colors.background
            colors.red
            colors.green
            colors.yellow
            colors.blue
            colors.purple
            colors.aqua
            colors.foreground
            colors.window
            colors.red
            colors.green
            colors.yellow
            colors.blue
            colors.purple
            colors.aqua
            colors.foreground
          ];
        };

        # -- top bar / window chrome
        "window.titleBarStyle" = "custom";

        "titleBar.activeBackground" = colors.background;
        "titleBar.activeForeground" = colors.foreground;

        "titleBar.inactiveBackground" = colors.background;
        "titleBar.inactiveForeground" = colors.comment;

        "titleBar.border" = colors.line;

        "commandCenter.background" = colors.line;
        "commandCenter.foreground" = colors.foreground;
        "commandCenter.border" = colors.line;

        "commandCenter.activeBackground" = colors.selection;
        "commandCenter.activeForeground" = colors.foreground;

        "window.activeBorder" = colors.line;
        "window.inactiveBorder" = colors.line;

        # ============================================================
        # -- syntax theming
        # ============================================================

        "editor.semanticHighlighting.enabled" = false;

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            {
              scope = "comment";
              settings.foreground = colors.comment;
            }
            {
              scope = "string";
              settings.foreground = colors.green;
            }
            {
              scope = "keyword";
              settings.foreground = colors.purple;
            }
            {
              scope = "entity.name.function";
              settings.foreground = colors.blue;
            }
            {
              scope = "entity.name.type";
              settings.foreground = colors.yellow;
            }

            {
              scope = ["constant.language" "support.constant"];
              settings.foreground = colors.yellow;
            }

            {
              scope = "constant.numeric";
              settings.foreground = colors.orange;
            }
            {
              scope = "punctuation";
              settings.foreground = colors.comment;
            }
            {
              scope = "variable";
              settings.foreground = colors.foreground;
            }

            {
              scope = [
                "entity.other.attribute-name"
                "entity.other.attribute-name.multipart.nix"
              ];
              settings.foreground = colors.foreground;
            }
          ];
        };
      };
    };
  };
}
