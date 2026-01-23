{pkgs, ...}: let
  colors = {
    # -- base
    foreground = "#c5c8c6";
    background = "#1d1f21";
    selection = "#373b41";
    line = "#282a2e";
    comment = "#969896";
    window = "#4d5057";

    # -- accents
    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";

    # -- utility
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

        # -- updates & recommendations
        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "extensions.ignoreRecommendations" = true;

        # -- startup / welcome
        "workbench.startupEditor" = "none";
        "workbench.welcome.enabled" = false;
        "workbench.tips.enabled" = false;
        "workbench.enableExperiments" = false;

        # -- fonts & cursor
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.cursorStyle" = "line";
        "editor.cursorBlinking" = "solid";
        "editor.cursorSmoothCaretAnimation" = "on";

        # -- layout
        "editor.minimap.enabled" = false;
        "workbench.tree.indent" = 20;
        "workbench.colorTheme" = "Default Dark Modern";
        "workbench.iconTheme" = "vs-seti";

        # -- titlebar (top bar)
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "classic";

        # ============================================================
        # -- ui theming
        # ============================================================
        "workbench.colorCustomizations" = {
          # -- core editor
          "editor.background" = colors.background;
          "editor.foreground" = colors.foreground;

          # -- editor text selection (leave as regular selection)
          "editor.selectionBackground" = colors.selection;
          "editor.selectionForeground" = colors.foreground;
          "editor.selectionHighlightBackground" = colors.selection;
          "editor.selectionHighlightBorder" = colors.transparent;

          # -- current line
          "editor.lineHighlightBackground" = colors.line;

          # -- cursor and line numbers
          "editorCursor.foreground" = colors.foreground;
          "editorLineNumber.foreground" = colors.window;
          "editorLineNumber.activeForeground" = colors.foreground;

          # -- remove implicit focus accent
          "focusBorder" = colors.transparent;
          "contrastBorder" = colors.transparent;

          # -- activity bar (left vertical) - remove selection bar & implicit accent
          "activityBar.background" = colors.background;
          "activityBar.foreground" = colors.foreground;
          "activityBar.inactiveForeground" = colors.comment;
          "activityBar.border" = colors.line;
          "activityBar.activeBorder" = colors.transparent;
          "activityBar.activeFocusBorder" = colors.transparent;

          # -- sidebar / explorer
          "sideBar.background" = colors.background;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.line;

          # -- explorer selection (restore green selection here)
          "list.activeSelectionBackground" = colors.green;
          "list.activeSelectionForeground" = colors.background;
          "list.activeSelectionIconForeground" = colors.background;
          "list.inactiveSelectionBackground" = colors.line;
          "list.inactiveSelectionForeground" = colors.foreground;
          "list.hoverBackground" = colors.selection;
          "list.focusOutline" = colors.transparent;
          "tree.indentGuidesStroke" = colors.line;

          # -- tabs: return green selection for editor tabs
          # active tab = green background, text = background color (consistent with explorer)
          "tab.activeBackground" = colors.green;
          "tab.activeForeground" = colors.background;

          "tab.inactiveBackground" = colors.background;
          "tab.inactiveForeground" = colors.comment;

          # remove thin underlines and borders for tabs completely
          "tab.activeBorderTop" = colors.transparent;
          "tab.unfocusedActiveBorderTop" = colors.transparent;
          "tab.selectedBorderTop" = colors.transparent;
          "tab.border" = colors.transparent;
          "tab.activeBorder" = colors.transparent;
          "tab.unfocusedActiveBorder" = colors.transparent;
          "tab.activeModifiedBorder" = colors.transparent;

          # try to prevent SCM/problems from recoloring text in tabs (best effort)
          "tab.activeModifiedForeground" = colors.background;
          "tab.inactiveModifiedForeground" = colors.comment;
          "problems.decorations.enabled" = false;
          "scm.diffDecorations" = "none";

          # -- top/title bar: use green selection when active (as requested)
          "titleBar.activeBackground" = colors.green;
          "titleBar.activeForeground" = colors.background;
          "titleBar.inactiveBackground" = colors.background;
          "titleBar.inactiveForeground" = colors.comment;
          "titleBar.border" = colors.line;

          # also style command center (search/command) active state in green
          "commandCenter.background" = colors.line;
          "commandCenter.foreground" = colors.foreground;
          "commandCenter.border" = colors.line;
          "commandCenter.activeBackground" = colors.green;
          "commandCenter.activeForeground" = colors.background;

          # -- panels
          "panel.background" = colors.background;
          "panel.border" = colors.line;
          "panelTitle.activeForeground" = colors.foreground;
          "panelTitle.inactiveForeground" = colors.comment;

          # -- inputs & dropdowns
          "input.background" = colors.line;
          "input.foreground" = colors.foreground;
          "input.border" = colors.line;
          "dropdown.background" = colors.line;
          "dropdown.foreground" = colors.foreground;
          "dropdown.border" = colors.line;

          # -- scrollbar (force styled scrollbar)
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

          # -- gutter & overview ruler (vertical diff lines)
          "editorGutter.addedBackground" = colors.green;
          "editorGutter.modifiedBackground" = colors.yellow;
          "editorGutter.deletedBackground" = colors.red;

          "editorOverviewRuler.addedForeground" = "${colors.green}99";
          "editorOverviewRuler.modifiedForeground" = "${colors.yellow}99";
          "editorOverviewRuler.deletedForeground" = "${colors.red}99";
          "editorOverviewRuler.commonContentForeground" = "${colors.window}99";
          "editorOverviewRuler.warningForeground" = colors.orange;

          # -- diagnostics (problems)
          "editorError.foreground" = colors.red;
          "editorWarning.foreground" = colors.orange;
          "editorInfo.foreground" = colors.foreground; # avoid implicit blue accent
          "editorHint.foreground" = colors.comment;

          "editor.errorDecoration" = "underline";
          "editor.warningDecoration" = "underline";
          "editor.infoDecoration" = "underline";

          # -- search / find
          "editor.findMatchBackground" = colors.line;
          "editor.findMatchBorder" = colors.line;
          "editor.findMatchHighlightBackground" = colors.selection;

          # -- welcome
          "welcomePage.background" = colors.background;
          "welcomePage.tileBackground" = colors.line;
          "welcomePage.tileHoverBackground" = colors.selection;
          "welcomePage.tileBorder" = colors.line;
          "welcomePage.tileShadow" = colors.transparent;

          # -- debug view + links (avoid implicit blue)
          "debugToolBar.background" = colors.line;
          "debugToolBar.border" = colors.line;
          "textLink.foreground" = colors.blue; # links still blue for discoverability
          "textLink.activeForeground" = colors.aqua;
          "debugConsole.infoForeground" = colors.blue;
          "debugConsole.warningForeground" = colors.yellow;
          "debugConsole.errorForeground" = colors.red;
          "debugConsoleLink.foreground" = colors.blue;

          # -- terminal (UI)
          "terminal.background" = colors.background;
          "terminal.foreground" = colors.foreground;
          "terminal.border" = colors.line;
          "terminal.selectionBackground" = colors.selection;

          # -- terminal tabs: remove notification dots and underlines
          "terminal.tab.activeBackground" = colors.line;
          "terminal.tab.activeForeground" = colors.foreground;
          "terminal.tab.inactiveBackground" = colors.background;
          "terminal.tab.inactiveForeground" = colors.comment;
          "terminal.tab.activeBorder" = colors.transparent;
          "terminal.tab.activeBorderTop" = colors.transparent;
          "terminal.tab.activeIconForeground" = colors.transparent; # remove notification dot
          "terminal.tab.inactiveIconForeground" = colors.transparent; # remove notification dot

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

          # -- hover & word highlight
          "editor.wordHighlightBackground" = colors.selection;
          "editor.wordHighlightStrongBackground" = colors.selection;

          "editorHoverWidget.background" = colors.line;
          "editorHoverWidget.foreground" = colors.foreground;
          "editorHoverWidget.border" = colors.line;

          # -- suggest / completion popup (style text + selection)
          "suggestWidget.background" = colors.background;
          "suggestWidget.foreground" = colors.foreground;
          "suggestWidget.border" = colors.line;

          "suggestWidget.selectedBackground" = colors.selection;
          "suggestWidget.selectedForeground" = colors.foreground;

          "suggestWidget.highlightForeground" = colors.yellow; # matched text color
          "suggestWidget.detailForeground" = colors.comment; # secondary text (module, return types)
          "suggestWidget.documentationFontSize" = 12;

          # sometimes VS Code uses editorSuggest* tokens too
          "editorSuggestWidget.background" = colors.background;
          "editorSuggestWidget.border" = colors.line;
          "editorSuggestWidget.selectedForeground" = colors.foreground;

          # scrollbar in suggest widget
          "suggestWidgetScrollbarSlider.background" = colors.window;
          "suggestWidgetScrollbarSlider.hoverBackground" = colors.comment;
          "suggestWidgetScrollbarSlider.activeBackground" = colors.foreground;

          # -- buttons / badges / extension buttons
          "button.background" = colors.foreground; # neutralize implicit accent
          "button.foreground" = colors.background;
          "button.hoverBackground" = colors.line;
          "button.border" = colors.transparent;

          "button.secondaryBackground" = colors.transparent;
          "button.secondaryForeground" = colors.foreground;

          "badge.background" = colors.window;
          "badge.foreground" = colors.background;

          "extensionButton.background" = colors.line;
          "extensionButton.foreground" = colors.foreground;
          "extensionButton.hoverBackground" = colors.selection;
          "extensionButton.prominentBackground" = colors.blue;
          "extensionButton.prominentForeground" = colors.background;
          "extensionButton.separator" = colors.window;

          # -- menus / context menus
          "menu.background" = colors.background;
          "menu.foreground" = colors.foreground;
          "menu.selectionBackground" = colors.green; # top panel menu selection -> green
          "menu.selectionForeground" = colors.background;
          "menu.separatorBackground" = colors.line;
          "menu.border" = colors.line;

          "menubar.selectionBackground" = colors.green;
          "menubar.selectionForeground" = colors.background;
          "menubar.selectionBorder" = colors.transparent;

          # -- notifications
          "notifications.background" = colors.background;
          "notifications.foreground" = colors.foreground;
          "notifications.border" = colors.line;
          "notificationLink.foreground" = colors.blue;
          "notificationsInfoIcon.foreground" = colors.blue;
          "notificationsErrorIcon.foreground" = colors.red;
          "notificationsWarningIcon.foreground" = colors.orange;

          # -- breadcrumbs
          "breadcrumb.background" = colors.background;
          "breadcrumb.foreground" = colors.comment;
          "breadcrumb.focusForeground" = colors.foreground;
          "breadcrumb.activeSelectionForeground" = colors.foreground;

          # -- diff editor inline
          "diffEditor.insertedTextBackground" = "${colors.green}33";
          "diffEditor.removedTextBackground" = "${colors.red}33";

          # -- bracket highlighting (brackets themselves)
          "editorBracketMatch.background" = colors.transparent;
          "editorBracketMatch.border" = colors.transparent;
          "editorBracketHighlight.foreground1" = colors.purple;
          "editorBracketHighlight.foreground2" = colors.purple;
          "editorBracketHighlight.foreground3" = colors.purple;
          "editorBracketHighlight.foreground4" = colors.purple;
          "editorBracketHighlight.foreground5" = colors.purple;
          "editorBracketHighlight.foreground6" = colors.purple;
          "editorBracketHighlight.unexpectedBracket.foreground" = colors.red;

          # -- bracket pair guides (block) keep transparent
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

          # -- thin vertical bracket guide line: use selection color
          "editor.guides.bracketPairs" = colors.selection;
          "editor.guides.bracketPairsActive" = colors.selection;
        };

        # -- editor behavior
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        # ============================================================
        # -- semantic + syntax token mappings (broad coverage)
        # ============================================================

        "editor.semanticHighlighting.enabled" = true;

        "editor.semanticTokenColorCustomizations" = {
          rules = {
            # -- general tokens
            "variable" = colors.foreground;
            "parameter" = colors.foreground;
            "property" = colors.foreground;
            "function" = colors.blue;
            "method" = colors.blue;
            "type" = colors.yellow;
            "class" = colors.yellow;
            "keyword" = colors.purple;
            "string" = colors.green;
            "number" = colors.orange;
            "boolean" = colors.purple;
            "namespace" = colors.foreground;
            "enum" = colors.yellow;
          };
        };

        # -- textmate rules: add language-specific rules (python, cpp, css, json, yaml, js, toml)
        "editor.tokenColorCustomizations" = {
          textMateRules = [
            # -- comments
            {
              scope = "comment";
              settings.foreground = colors.comment;
            }

            # -- python
            {
              scope = "source.python string";
              settings.foreground = colors.green;
            }
            {
              scope = "source.python constant.numeric";
              settings.foreground = colors.orange;
            }
            {
              scope = "source.python keyword.control";
              settings.foreground = colors.purple;
            }
            {
              scope = "source.python constant.language.boolean";
              settings.foreground = colors.purple;
            }
            {
              scope = "entity.name.function.python";
              settings.foreground = colors.blue;
            }
            {
              scope = "variable.parameter.function.python";
              settings.foreground = colors.foreground;
            }

            # -- c / c++
            {
              scope = "source.c++ entity.name.function";
              settings.foreground = colors.blue;
            }
            {
              scope = "source.cpp entity.name.function";
              settings.foreground = colors.blue;
            }
            {
              scope = "source.c keyword.control";
              settings.foreground = colors.purple;
            }
            {
              scope = "storage.type.c";
              settings.foreground = colors.yellow;
            }
            {
              scope = "storage.type.cpp";
              settings.foreground = colors.yellow;
            }
            {
              scope = "constant.numeric.cpp";
              settings.foreground = colors.orange;
            }

            # -- javascript / typescript
            {
              scope = "source.js string";
              settings.foreground = colors.green;
            }
            {
              scope = "source.js constant.numeric";
              settings.foreground = colors.orange;
            }
            {
              scope = "source.js keyword.operator";
              settings.foreground = colors.purple;
            }
            {
              scope = "source.js entity.name.function";
              settings.foreground = colors.blue;
            }
            {
              scope = "source.ts keyword";
              settings.foreground = colors.purple;
            }

            # -- css
            {
              scope = "source.css entity.name.tag.css";
              settings.foreground = colors.yellow;
            }
            {
              scope = "source.css support.type.property-name.css";
              settings.foreground = colors.purple;
            }
            {
              scope = "source.css string.quoted";
              settings.foreground = colors.green;
            }

            # -- json
            {
              scope = "source.json string.quoted";
              settings.foreground = colors.green;
            }
            {
              scope = "source.json constant.numeric";
              settings.foreground = colors.orange;
            }
            {
              scope = "source.json entity.name.section";
              settings.foreground = colors.yellow;
            }

            # -- yaml
            {
              scope = "source.yaml key";
              settings.foreground = colors.yellow;
            }
            {
              scope = "source.yaml constant.scalar";
              settings.foreground = colors.green;
            }
            {
              scope = "source.yaml constant.numeric";
              settings.foreground = colors.orange;
            }

            # -- toml
            {
              scope = "source.toml string";
              settings.foreground = colors.green;
            }
            {
              scope = "source.toml constant.numeric";
              settings.foreground = colors.orange;
            }
            {
              scope = "source.toml entity.name.section";
              settings.foreground = colors.yellow;
            }

            # -- punctuation / brackets (force single color)
            {
              scope = "punctuation";
              settings.foreground = colors.purple;
            }
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

            # -- fallback
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
