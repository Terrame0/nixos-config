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

        # -- fonts and cursor
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

        # -- disable welcome / startup pages
        "workbench.startupEditor" = "none";
        "workbench.welcome.enabled" = false;
        "workbench.tips.enabled" = false;
        "workbench.enableExperiments" = false;

        # -- disable walkthroughs and release notes
        "workbench.editor.showTabs" = true;
        "update.showReleaseNotes" = false;
        "extensions.showRecommendationsOnlyOnDemand" = true;

        # ============================================================
        # -- ui theming
        # ============================================================

        # ensure VS Code draws its own titlebar/menu so colors apply
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "toggle";

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
          "gitDecoration.untrackedResourceForeground" = colors.aqua;
          "gitDecoration.ignoredResourceForeground" = colors.comment;

          # -- diagnostics
          "editorError.foreground" = colors.red;
          "editorWarning.foreground" = colors.orange;
          "editorInfo.foreground" = colors.blue;
          "editorHint.foreground" = colors.comment;

          # -- search
          "editor.findMatchBackground" = colors.line;
          "editor.findMatchBorder" = colors.line;
          "editor.findMatchHighlightBackground" = colors.selection;

          # -- welcome
          "welcomePage.background" = colors.background;
          "welcomePage.tileBackground" = colors.line;
          "welcomePage.tileHoverBackground" = colors.selection;
          "welcomePage.tileBorder" = colors.line;
          "welcomePage.tileShadow" = "#00000000";

          # -- debug
          "debugToolBar.background" = colors.line;
          "debugToolBar.border" = colors.line;

          # -- terminal (UI)
          "terminal.background" = colors.background;
          "terminal.foreground" = colors.foreground;
          "terminal.border" = colors.line;

          "terminalCursor.foreground" = colors.foreground;
          "terminal.selectionBackground" = colors.selection;

          # proper 16-color ansi terminal mapping
          "terminal.ansiBlack" = colors.background;
          "terminal.ansiRed" = colors.red;
          "terminal.ansiGreen" = colors.green;
          "terminal.ansiYellow" = colors.yellow;
          "terminal.ansiBlue" = colors.blue;
          "terminal.ansiMagenta" = colors.purple;
          "terminal.ansiCyan" = colors.aqua;
          "terminal.ansiWhite" = colors.foreground;

          "terminal.ansiBrightBlack" = colors.window;
          "terminal.ansiBrightRed" = colors.red;
          "terminal.ansiBrightGreen" = colors.green;
          "terminal.ansiBrightYellow" = colors.yellow;
          "terminal.ansiBrightBlue" = colors.blue;
          "terminal.ansiBrightMagenta" = colors.purple;
          "terminal.ansiBrightCyan" = colors.aqua;
          "terminal.ansiBrightWhite" = colors.foreground;

          # -- buttons, badges, extension buttons
          "button.background" = colors.blue;
          "button.foreground" = colors.background;
          "button.hoverBackground" = colors.aqua;
          "button.border" = colors.line;

          "button.secondaryBackground" = colors.line;
          "button.secondaryForeground" = colors.foreground;
          "button.secondaryHoverBackground" = colors.selection;

          "badge.background" = colors.window;
          "badge.foreground" = colors.background;

          "extensionButton.background" = colors.line;
          "extensionButton.foreground" = colors.foreground;
          "extensionButton.hoverBackground" = colors.selection;
          "extensionButton.prominentBackground" = colors.blue;
          "extensionButton.prominentForeground" = colors.background;
          "extensionButton.prominentHoverBackground" = colors.aqua;
          "extensionButton.separator" = colors.window;

          # -- menus / context menus / menubar
          "menu.background" = colors.background;
          "menu.foreground" = colors.foreground;
          "menu.selectionBackground" = colors.selection;
          "menu.selectionForeground" = colors.foreground;
          "menu.separatorBackground" = colors.line;
          "menu.border" = colors.line;

          "menubar.selectionBackground" = colors.selection;
          "menubar.selectionForeground" = colors.foreground;
          "menubar.selectionBorder" = colors.line;

          # -- notifications / toasts
          "notifications.background" = colors.background;
          "notifications.foreground" = colors.foreground;
          "notifications.border" = colors.line;

          "notificationCenterHeader.background" = colors.background;
          "notificationCenterHeader.foreground" = colors.foreground;
          "notificationToast.background" = colors.line;
          "notificationToast.border" = colors.line;
          "notificationLink.foreground" = colors.blue;

          # -- breadcrumbs
          "breadcrumb.background" = colors.background;
          "breadcrumb.foreground" = colors.comment;
          "breadcrumb.focusForeground" = colors.foreground;
          "breadcrumb.activeSelectionForeground" = colors.foreground;

          # -- diff editor
          "diffEditor.insertedTextBackground" = "${colors.green}33";
          "diffEditor.removedTextBackground" = "${colors.red}33";

          # -- bracket highlighting (make all bracket depths the same color)
          "editorBracketMatch.background" = "#00000000";
          "editorBracketMatch.border" = colors.blue;
          "editorBracketHighlight.foreground1" = colors.blue;
          "editorBracketHighlight.foreground2" = colors.blue;
          "editorBracketHighlight.foreground3" = colors.blue;
          "editorBracketHighlight.foreground4" = colors.blue;
          "editorBracketHighlight.foreground5" = colors.blue;
          "editorBracketHighlight.foreground6" = colors.blue;
          "editorBracketHighlight.unexpectedBracket.foreground" = colors.red;

          # bracket guides (disable colors per-depth, use the same)
          "editorBracketPairGuide.activeBackground1" = colors.blue;
          "editorBracketPairGuide.activeBackground2" = colors.blue;
          "editorBracketPairGuide.activeBackground3" = colors.blue;
          "editorBracketPairGuide.activeBackground4" = colors.blue;
          "editorBracketPairGuide.activeBackground5" = colors.blue;
          "editorBracketPairGuide.activeBackground6" = colors.blue;

          "editorBracketPairGuide.background1" = "#00000000";
          "editorBracketPairGuide.background2" = "#00000000";
          "editorBracketPairGuide.background3" = "#00000000";
          "editorBracketPairGuide.background4" = "#00000000";
          "editorBracketPairGuide.background5" = "#00000000";
          "editorBracketPairGuide.background6" = "#00000000";
        };

        # ensure bracket pair colorization is enabled (we set all bracket colors to same above)
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        # ============================================================
        # -- syntax theming
        # ============================================================

        # semantic highlighting left off so textmate rules apply consistently
        "editor.semanticHighlighting.enabled" = false;

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            # -- comments
            {
              scope = "comment";
              settings.foreground = colors.comment;
            }

            # -- strings & interpolations
            {
              scope = "string";
              settings.foreground = colors.green;
            }
            {
              scope = "string.interpolated";
              settings.foreground = colors.green;
            }

            # -- numbers
            {
              scope = "constant.numeric";
              settings.foreground = colors.orange;
            }

            # -- keywords (nix keywords included)
            {
              scope = "keyword";
              settings.foreground = colors.purple;
            }
            {
              scope = "keyword.other.nix";
              settings.foreground = colors.purple;
            }
            {
              scope = "keyword.control.nix";
              settings.foreground = colors.purple;
            }
            {
              scope = "keyword.operator.nix";
              settings.foreground = colors.purple;
            }

            # -- functions & builtin functions
            {
              scope = "entity.name.function";
              settings.foreground = colors.blue;
            }
            {
              scope = "support.function.builtin.nix";
              settings.foreground = colors.blue;
            }
            {
              scope = "support.function";
              settings.foreground = colors.blue;
            }

            # -- types / constructors (rare in nix but keep)
            {
              scope = "entity.name.type";
              settings.foreground = colors.yellow;
            }

            # -- variables & parameters
            {
              scope = "variable";
              settings.foreground = colors.foreground;
            }
            {
              scope = "variable.parameter";
              settings.foreground = colors.foreground;
            }
            {
              scope = "variable.other.readwrite.nix";
              settings.foreground = colors.foreground;
            }

            # -- attribute names / attr paths (nix)
            {
              scope = [
                "entity.other.attribute-name"
                "entity.other.attribute-name.multipart.nix"
                "entity.name.attribute-name.nix"
                "variable.other.object.property.nix"
              ];
              settings.foreground = colors.foreground;
            }

            # -- punctuation: make general punctuation muted
            {
              scope = "punctuation";
              settings.foreground = colors.comment;
            }

            # -- brackets specifically (force parens/brackets/braces to one color)
            {
              scope = "punctuation.section.brackets";
              settings.foreground = colors.blue;
            }
            {
              scope = "punctuation.section.parens";
              settings.foreground = colors.blue;
            }
            {
              scope = "punctuation.section.block";
              settings.foreground = colors.blue;
            }
            {
              scope = "punctuation.definition.brackets";
              settings.foreground = colors.blue;
            }

            # -- selectors for nix-specific scopes (broad coverage)
            {
              scope = "source.nix";
              settings.foreground = colors.foreground;
            }
            {
              scope = "keyword.other.nix";
              settings.foreground = colors.purple;
            }
            {
              scope = "variable.other.constant.nix";
              settings.foreground = colors.yellow;
            }
            {
              scope = "entity.name.function.nix";
              settings.foreground = colors.blue;
            }
            {
              scope = "entity.name.variable.nix";
              settings.foreground = colors.foreground;
            }
            {
              scope = "support.constant.nix";
              settings.foreground = colors.yellow;
            }
            {
              scope = "storage.type.nix";
              settings.foreground = colors.purple;
            }
            {
              scope = "meta.attribute-set.nix";
              settings.foreground = colors.foreground;
            }

            # fallback: lighten punctuation and keep text readable
            {
              scope = "meta";
              settings.foreground = colors.foreground;
            }
          ];
        };
      };
    };
  };
}
