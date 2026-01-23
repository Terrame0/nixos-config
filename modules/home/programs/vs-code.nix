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
        "window.menuBarVisibility" = "classic";

        "workbench.colorCustomizations" = {
          # -- core editor
          "editor.background" = colors.background;
          "editor.foreground" = colors.foreground;

          # selection style: use green bg and dark text (text = background color)
          "editor.selectionBackground" = colors.selection;
          "editor.selectionForeground" = colors.foreground;

          # editor line highlight kept subtle
          "editor.lineHighlightBackground" = colors.line;

          "editorCursor.foreground" = colors.foreground;

          "editorLineNumber.foreground" = colors.window;
          "editorLineNumber.activeForeground" = colors.foreground;

          # -- focus & borders (disable visible outline so selection is just color swap)
          "focusBorder" = "#00000000";
          "contrastBorder" = "#00000000";

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
          # replace selection-border approach: active tab = green bg, text = background color
          "tab.activeBackground" = colors.green;
          "tab.activeForeground" = colors.background;

          "tab.inactiveBackground" = colors.background;
          "tab.inactiveForeground" = colors.comment;

          # -- git diffs dont affect tab colors
          "scm.diffDecorations" = "none";

          # remove the thin top border above active tab
          "tab.activeBorderTop" = "#00000000";
          "tab.unfocusedActiveBorderTop" = "#00000000";
          "tab.selectedBorderTop" = "#00000000";
          "tab.border" = "#00000000";

          # -- lists & trees (explorer)
          # selection style: green bg, text = background color
          "list.activeSelectionBackground" = colors.line;
          "list.activeSelectionForeground" = colors.background;
          "list.activeSelectionIconForeground" = colors.background;

          "list.inactiveSelectionBackground" = colors.line;
          "list.inactiveSelectionForeground" = colors.foreground;

          "list.hoverBackground" = colors.selection;
          "list.hoverForeground" = colors.foreground;

          "list.focusOutline" = "#00000000";
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

          # -- git decorations (explorer + generic)
          "gitDecoration.modifiedResourceForeground" = colors.orange;
          "gitDecoration.addedResourceForeground" = colors.green;
          "gitDecoration.deletedResourceForeground" = colors.red;
          "gitDecoration.untrackedResourceForeground" = colors.aqua;
          "gitDecoration.ignoredResourceForeground" = colors.comment;
          "gitDecoration.renamedResourceForeground" = colors.aqua;

          # -- gutter (left side of editor): explicit line/gutter markers for added/modified/deleted
          "editorGutter.addedBackground" = colors.green;
          "editorGutter.modifiedBackground" = colors.yellow;
          "editorGutter.deletedBackground" = colors.red;

          # -- overview ruler (vertical diff lines)
          "editorOverviewRuler.addedForeground" = "${colors.green}99";
          "editorOverviewRuler.modifiedForeground" = "${colors.yellow}99";
          "editorOverviewRuler.deletedForeground" = "${colors.red}99";
          "editorOverviewRuler.commonContentForeground" = "${colors.window}99";

          # -- diagnostics (problems)
          "editorError.foreground" = colors.red;
          "editorWarning.foreground" = colors.orange;
          "editorInfo.foreground" = colors.blue;
          "editorHint.foreground" = colors.comment;

          # underlines only (no extra borders)
          "editor.errorDecoration" = "underline";
          "editor.warningDecoration" = "underline";
          "editor.infoDecoration" = "underline";

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

          # debug links styling
          "textLink.foreground" = colors.blue;
          "textLink.activeForeground" = colors.aqua;
          "debugConsole.infoForeground" = colors.blue;
          "debugConsole.warningForeground" = colors.yellow;
          "debugConsole.errorForeground" = colors.red;
          "debugConsoleLink.foreground" = colors.blue;

          # -- terminal (UI)
          "terminal.background" = colors.background;
          "terminal.foreground" = colors.foreground;
          "terminal.border" = colors.line;

          "terminalCursor.foreground" = colors.foreground;
          "terminal.selectionBackground" = colors.selection;

          # proper 16-color ansi terminal mapping (these are the keys VS Code reads)
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
          "button.border" = "#00000000";

          "button.secondaryBackground" = "#00000000";
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

          # -- menus / context menus / menubar (top-bar context menus)
          "menu.background" = colors.background;
          "menu.foreground" = colors.foreground;
          "menu.selectionBackground" = colors.green;
          "menu.selectionForeground" = colors.background;
          "menu.separatorBackground" = colors.line;
          "menu.border" = colors.line;

          "menubar.selectionBackground" = colors.green;
          "menubar.selectionForeground" = colors.background;
          "menubar.selectionBorder" = "#00000000";

          # -- notifications / toasts
          "notifications.background" = colors.background;
          "notifications.foreground" = colors.foreground;
          "notifications.border" = colors.line;

          "notificationCenterHeader.background" = colors.background;
          "notificationCenterHeader.foreground" = colors.foreground;
          "notificationToast.background" = colors.line;
          "notificationToast.border" = colors.line;
          "notificationLink.foreground" = colors.blue;

          "notificationsInfoIcon.foreground" = colors.blue;
          "notificationsErrorIcon.foreground" = colors.red;
          "notificationsWarningIcon.foreground" = colors.orange;

          # -- breadcrumbs
          "breadcrumb.background" = colors.background;
          "breadcrumb.foreground" = colors.comment;
          "breadcrumb.focusForeground" = colors.foreground;
          "breadcrumb.activeSelectionForeground" = colors.foreground;

          # -- diff editor (inline)
          "diffEditor.insertedTextBackground" = "${colors.green}33";
          "diffEditor.removedTextBackground" = "${colors.red}33";

          # -- bracket highlighting (make all bracket depths the same color)
          # remove border and use green background to follow the 'selection as green' pattern
          "editorBracketMatch.background" = colors.selection;
          "editorBracketMatch.border" = "#00000000";
          "editorBracketHighlight.foreground1" = colors.purple;
          "editorBracketHighlight.foreground2" = colors.purple;
          "editorBracketHighlight.foreground3" = colors.purple;
          "editorBracketHighlight.foreground4" = colors.purple;
          "editorBracketHighlight.foreground5" = colors.purple;
          "editorBracketHighlight.foreground6" = colors.purple;
          "editorBracketHighlight.unexpectedBracket.foreground" = colors.red;

          # bracket pair guides (use selection color but ensure no visual border)
          "editorBracketPairGuide.activeBackground1" = "#00000000";
          "editorBracketPairGuide.activeBackground2" = "#00000000";
          "editorBracketPairGuide.activeBackground3" = "#00000000";
          "editorBracketPairGuide.activeBackground4" = "#00000000";
          "editorBracketPairGuide.activeBackground5" = "#00000000";
          "editorBracketPairGuide.activeBackground6" = "#00000000";

          "editorBracketPairGuide.background1" = "#00000000";
          "editorBracketPairGuide.background2" = "#00000000";
          "editorBracketPairGuide.background3" = "#00000000";
          "editorBracketPairGuide.background4" = "#00000000";
          "editorBracketPairGuide.background5" = "#00000000";
          "editorBracketPairGuide.background6" = "#00000000";
        };

        # -- ensure bracket pair colorization is enabled
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        # ============================================================
        # -- syntax theming
        # ============================================================

        # enable semantic highlighting and supply rules so language-server tokens follow palette
        "editor.semanticHighlighting.enabled" = true;

        "editor.semanticTokenColorCustomizations" = {
          rules = {
            # variables / params / properties
            "variable" = colors.foreground;
            "parameter" = colors.foreground;
            "property" = colors.foreground;

            # functions
            "function" = colors.blue;

            # types
            "type" = colors.yellow;

            # keywords
            "keyword" = colors.purple;

            # strings & numbers & booleans
            "string" = colors.green;
            "number" = colors.orange;
            "boolean" = colors.purple;
          };
        };

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

            # -- booleans (true / false)
            {
              scope = ["constant.language.boolean" "constant.language.true" "constant.language.false"];
              settings.foreground = colors.purple;
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

            # -- types / constructors
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
                "meta.attribute-set.nix"
              ];
              settings.foreground = colors.foreground;
            }

            # -- punctuation: muted by default, but bracket punctuation forced below
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
            {
              scope = "punctuation.definition.parameters";
              settings.foreground = colors.blue;
            }

            # -- broad nix coverage: ensure keyword.other.nix and source.nix are covered
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

            # fallback to keep meta sections readable
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
