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
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        jnoortheen.nix-ide
        charliermarsh.ruff
        mads-hartmann.bash-ide-vscode
        llvm-vs-code-extensions.vscode-clangd
        ecmel.vscode-html-css
      ];

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

        # -- terminal
        "terminal.external.linuxExec" = "alacritty";

        # -- disable updates
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;

        # -- cursor
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

        # -- UI theming
        "workbench.colorCustomizations" = {
          "editor.semanticHighlighting.enabled" = false;

          "editor.background" = colors.background;
          "editor.foreground" = colors.foreground;

          "editor.selectionBackground" = colors.selection;
          "editor.lineHighlightBackground" = colors.line;

          "editorCursor.foreground" = colors.foreground;

          "editorLineNumber.foreground" = colors.window;
          "editorLineNumber.activeForeground" = colors.foreground;

          # Sidebar
          "sideBar.background" = colors.line;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.line;

          # Activity bar
          "activityBar.background" = colors.background;
          "activityBar.foreground" = colors.blue;
          "activityBar.inactiveForeground" = colors.window;
          "activityBar.border" = colors.line;

          # Status bar
          "statusBar.background" = colors.background;
          "statusBar.foreground" = colors.foreground;
          "statusBar.border" = colors.line;

          # Tabs
          "tab.activeBackground" = colors.green;
          "tab.activeForeground" = colors.background;

          "tab.inactiveForeground" = colors.comment;
          "tab.inactiveBackground" = colors.background;

          "tab.border" = colors.line;

          # Errors
          "editorError.foreground" = colors.red;
          "editorError.border" = colors.red;

          # Warnings
          "editorWarning.foreground" = colors.orange;
          "editorWarning.border" = colors.orange;

          # Info / hints
          "editorInfo.foreground" = colors.blue;
          "editorInfo.border" = colors.blue;

          # Deprecated (strikethrough)
          "editorDeprecated.foreground" = colors.window;

          "editor.errorDecoration" = "underline";
          "editor.warningDecoration" = "underline";
          "editor.infoDecoration" = "underline";
        };

        # -- syntax theming
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
              scope = [
                "constant.language"
                "support.constant"
              ];
              settings.foreground = colors.yellow;
            }
            {
              scope = "punctuation";
              settings.foreground = colors.comment;
            }
            {
              scope = "constant.numeric";
              settings.foreground = colors.orange;
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
              settings = {
                foreground = colors.foreground;
              };
            }
          ];
        };
      };
    };
  };
}
