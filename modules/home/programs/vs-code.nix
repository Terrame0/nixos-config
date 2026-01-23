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

    # -- transparent token used instead of literal "#00000000"
    transparent = "#00000000";
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
        "extensions.ignoreRecommendations" = true;

        # ============================================================
        # -- ui theming
        # ============================================================

        # -- ensure VS Code draws its own titlebar/menu so colors apply
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "classic";

        "workbench.colorCustomizations" = {
          # -- core editor
          "editor.background" = colors.background;
          "editor.foreground" = colors.foreground;

          # -- editor selection
          "editor.selectionBackground" = colors.selection;
          "editor.selectionForeground" = colors.foreground;
          "editor.selectionHighlightBackground" = colors.selection;
          "editor.selectionHighlightBorder" = colors.transparent;

          # -- editor line highlight
          "editor.lineHighlightBackground" = colors.line;

          "editorCursor.foreground" = colors.foreground;

          "editorLineNumber.foreground" = colors.window;
          "editorLineNumber.activeForeground" = colors.foreground;

          # -- focus & borders
          "focusBorder" = colors.transparent;
          "contrastBorder" = colors.transparent;

          # -- sidebar / activity / status
          "sideBar.background" = colors.background;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.line;

          "activityBar.background" = colors.background;
          "activityBar.foreground" = colors.foreground;
          "activityBar.inactiveForeground" = colors.comment;
          # -- remove activity bar selection bar
          "activityBar.activeBorder" = colors.transparent;
          "activityBar.activeFocusBorder" = colors.transparent;
          "activityBar.activeBackground" = colors.background;
          "activityBar.inactiveBackground" = colors.background;
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
          # -- disable green selection for tabs: active = line bg + fg text
          "problems.decorations.enabled" = false;

          "tab.activeBackground" = colors.line;
          "tab.activeForeground" = colors.foreground;

          "tab.inactiveBackground" = colors.background;
          "tab.inactiveForeground" = colors.comment;

          # remove any active/selected thin top border
          "tab.activeBorderTop" = colors.transparent;
          "tab.unfocusedActiveBorderTop" = colors.transparent;
          "tab.selectedBorderTop" = colors.transparent;
          "tab.border" = colors.transparent;

          # mitigate modified/problem overrides (best-effort)
          "tab.activeModifiedBorder" = colors.transparent;
          "tab.inactiveModifiedBorder" = colors.transparent;
          "tab.activeModifiedForeground" = colors.foreground;
          "tab.inactiveModifiedForeground" = colors.comment;

          # make sure scm doesn't recolor tab backgrounds
          "scm.diffDecorations" = "none";

          # -- lists & trees (explorer)
          # explorer selection: use subtle line bg + fg text
          "list.activeSelectionBackground" = colors.line;
          "list.activeSelectionForeground" = colors.foreground;
          "list.activeSelectionIconForeground" = colors.foreground;

          "list.inactiveSelectionBackground" = colors.line;
          "list.inactiveSelectionForeground" = colors.foreground;

          "list.hoverBackground" = colors.selection;
          "list.hoverForeground" = colors.foreground;

          "list.focusOutline" = colors.transparent;
          "tree.indentGuidesStroke" = colors.line;

          # -- inputs
          "input.background" = colors.line;
          "input.foreground" = colors.foreground;
          "input.border" = colors.line;

          "dropdown.background" = colors.line;
          "dropdown.foreground" = colors.foreground;
          "dropdown.border" = colors.line;

          # -- scrollbar
          # ensure scrollbar tokens are set (this fixes non-styled scrollbars)
          "scrollbar.shadow" = colors.transparent;
          "scrollbarSlider.background" = "${colors.window}99";
          "scrollbarSlider.hoverBackground" = "${colors.comment}cc";
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

          # -- overview ruler (vertical diff lines / modified markers)
          "editorOverviewRuler.addedForeground" = "${colors.green}99";
          "editorOverviewRuler.modifiedForeground" = "${colors.yellow}99";
          "editorOverviewRuler.deletedForeground" = "${colors.red}99";
          "editorOverviewRuler.commonContentForeground" = "${colors.window}99";
          "editorOverviewRuler.warningForeground" = colors.orange;

          # -- diagnostics (problems)
          "editorError.foreground" = colors.red;
          "editorWarning.foreground" = colors.orange;
          "editorInfo.foreground" = colors.blue;
          "editorHint.foreground" = colors.comment;

          # only underline decorations for problems
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
          "welcomePage.tileShadow" = colors.transparent;

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

          # -- terminal tabs & notification dots
          "terminal.tab.activeBackground" = colors.line;
          "terminal.tab.activeForeground" = colors.foreground;
          "terminal.tab.inactiveBackground" = colors.background;
          "terminal.tab.inactiveForeground" = colors.comment;
          "terminal.tab.activeBorder" = colors.transparent;
          "terminal.tab.activeBorderTop" = colors.transparent;
          "terminal.tab.activeIconForeground" = colors.foreground;
          "terminal.tab.inactiveIconForeground" = colors.comment;

          # -- terminal ansi colors (16)
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

          # -- word under cursor / hover highlight
          "editor.wordHighlightBackground" = colors.selection;
          "editor.wordHighlightStrongBackground" = colors.selection;

          # -- hover widget itself
          "editorHoverWidget.background" = colors.line;
          "editorHoverWidget.foreground" = colors.foreground;
          "editorHoverWidget.border" = colors.line;

          # -- symbol occurrences
          "editor.wordHighlightBorder" = colors.transparent;
          "editor.wordHighlightStrongBorder" = colors.transparent;

          # -- suggest / autocomplete widget
          "suggestWidget.background" = colors.background;
          "suggestWidget.foreground" = colors.foreground;
          "suggestWidget.border" = colors.line;

          # selected item in suggest
          "suggestWidget.selectedBackground" = colors.selection;
          "suggestWidget.selectedForeground" = colors.foreground;

          # matched text in suggest
          "suggestWidget.highlightForeground" = colors.yellow;

          # documentation pane inside suggest
          "suggestWidget.focusHighlightForeground" = colors.blue;
          "editorSuggestWidget.background" = colors.background;
          "editorSuggestWidget.border" = colors.line;

          # scrollbar inside suggest widget
          "suggestWidgetScrollbarSlider.background" = colors.window;
          "suggestWidgetScrollbarSlider.hoverBackground" = colors.comment;
          "suggestWidgetScrollbarSlider.activeBackground" = colors.foreground;

          # -- buttons, badges, extension buttons
          "button.background" = colors.blue;
          "button.foreground" = colors.background;
          "button.hoverBackground" = colors.aqua;
          "button.border" = colors.transparent;

          "button.secondaryBackground" = colors.transparent;
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
          "menu.selectionBackground" = colors.selection;
          "menu.selectionForeground" = colors.foreground;
          "menu.separatorBackground" = colors.line;
          "menu.border" = colors.line;

          "menubar.selectionBackground" = colors.selection;
          "menubar.selectionForeground" = colors.foreground;
          "menubar.selectionBorder" = colors.transparent;

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

          # -- bracket highlighting: brackets themselves and guides
          "editorBracketMatch.background" = colors.transparent;
          "editorBracketMatch.border" = colors.transparent;

          "editorBracketHighlight.foreground1" = colors.purple;
          "editorBracketHighlight.foreground2" = colors.purple;
          "editorBracketHighlight.foreground3" = colors.purple;
          "editorBracketHighlight.foreground4" = colors.purple;
          "editorBracketHighlight.foreground5" = colors.purple;
          "editorBracketHighlight.foreground6" = colors.purple;
          "editorBracketHighlight.unexpectedBracket.foreground" = colors.red;

          # bracket pair guides (block background) - keep invisible or transparent
          "editorBracketPairGuide.activeBackground1" = colors.transparent;
          "editorBracketPairGuide.activeBackground2" = colors.transparent;
          "editorBracketPairGuide.activeBackground3" = colors.transparent;
          "editorBracketPairGuide.activeBackground4" = colors.transparent;
          "editorBracketPairGuide.activeBackground5" = colors.transparent;
          "editorBracketPairGuide.activeBackground6" = colors.transparent;

          "editorBracketPairGuide.background1" = colors.transparent;
          "editorBracketPairGuide.background2" = colors.transparent;
          "editorBracketPairGuide.background3" = colors.transparent;
          "editorBracketPairGuide.background4" = colors.transparent;
          "editorBracketPairGuide.background5" = colors.transparent;
          "editorBracketPairGuide.background6" = colors.transparent;

          # thin vertical line connecting brackets: set to selection color
          "editor.guides.bracketPairs" = colors.selection;
          "editor.guides.bracketPairsActive" = colors.selection;
        };

        # -- ensure bracket pair colorization is enabled and guides behavior set to active
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        # ============================================================
        # -- syntax theming
        # ============================================================

        # enable semantic highlighting and supply rules so language-server tokens follow palette
        "editor.semanticHighlighting.enabled" = true;

        "editor.semanticTokenColorCustomizations" = {
          rules = {
            # -- variables / params / properties
            "variable" = colors.foreground;
            "parameter" = colors.foreground;
            "property" = colors.foreground;

            # -- functions
            "function" = colors.blue;

            # -- types
            "type" = colors.yellow;

            # -- keywords
            "keyword" = colors.purple;

            # -- strings & numbers & booleans
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

            # -- punctuation: muted by default; brackets forced below
            {
              scope = "punctuation";
              settings.foreground = colors.comment;
            }

            # -- brackets specifically (force parens/brackets/braces to one color)
            {
              scope = "punctuation.section.brackets";
              settings.foreground = colors.purple;
            }
            {
              scope = "punctuation.section.parens";
              settings.foreground = colors.purple;
            }
            {
              scope = "punctuation.section.block";
              settings.foreground = colors.purple;
            }
            {
              scope = "punctuation.definition.brackets";
              settings.foreground = colors.purple;
            }
            {
              scope = "punctuation.definition.parameters";
              settings.foreground = colors.purple;
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
