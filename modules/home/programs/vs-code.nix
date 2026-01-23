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
          "activityBar.border" = colors.transparent;
          "activityBar.activeBorder" = colors.transparent;
          "activityBar.activeFocusBorder" = colors.transparent;

          # -- sidebar / explorer
          "sideBar.background" = colors.background;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.transparent;

          # -- tabs: return green selection for editor tabs
          # active tab = green background, text = background color (consistent with explorer)
          "tab.activeBackground" = colors.line;
          "tab.activeForeground" = colors.foreground;

          "tab.inactiveBackground" = colors.background;
          "tab.inactiveForeground" = colors.comment;

          # remove thin underlines and borders for tabs completely
          "tab.inactiveBorder" = colors.transparent;
          "tab.unfocusedInactiveBorder" = colors.transparent;
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
          "titleBar.activeBackground" = colors.background;
          "titleBar.activeForeground" = colors.foreground;
          "titleBar.inactiveBackground" = colors.background;
          "titleBar.inactiveForeground" = colors.comment;
          "titleBar.border" = colors.transparent;

          # also style command center (search/command) active state in green
          "commandCenter.background" = colors.line;
          "commandCenter.foreground" = colors.foreground;
          "commandCenter.border" = colors.transparent;
          "commandCenter.activeBackground" = colors.selection;
          "commandCenter.activeForeground" = colors.foreground;

          # -- panels
          "panel.background" = colors.background;
          "panel.border" = colors.transparent;
          "panelTitle.activeForeground" = colors.foreground;
          "panelTitle.inactiveForeground" = colors.comment;

          # -- inputs & dropdowns
          "input.background" = colors.line;
          "input.foreground" = colors.foreground;
          "input.border" = colors.transparent;
          "dropdown.background" = colors.line;
          "dropdown.foreground" = colors.foreground;
          "dropdown.border" = colors.transparent;

          # -- scrollbar (force styled scrollbar)
          "scrollbar.shadow" = colors.transparent;
          "scrollbarSlider.background" = "${colors.window}99";
          "scrollbarSlider.hoverBackground" = "${colors.comment}cc";
          "scrollbarSlider.activeBackground" = colors.foreground;

          # -- git decorations (explorer + generic)
          "gitDecoration.modifiedResourceForeground" = colors.yellow;
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
          # active (currently selected) match
          "editor.findMatchForeground" = colors.background;
          "editor.findMatchBackground" = colors.green;
          "editor.findMatchBorder" = colors.transparent;

          # other matches
          "editor.findMatchHighlightForeground" = colors.background;
          "editor.findMatchHighlightBackground" = colors.foreground;
          "editor.findMatchHighlightBorder" = colors.transparent;

          # other matches

          # -- welcome
          "welcomePage.background" = colors.background;
          "welcomePage.tileBackground" = colors.line;
          "welcomePage.tileHoverBackground" = colors.selection;
          "welcomePage.tileBorder" = colors.transparent;
          "welcomePage.tileShadow" = colors.transparent;

          # -- debug view + links (avoid implicit blue)
          "debugToolBar.background" = colors.line;
          "debugToolBar.border" = colors.transparent;
          "textLink.foreground" = colors.blue; # links still blue for discoverability
          "textLink.activeForeground" = colors.aqua;
          "debugConsole.infoForeground" = colors.blue;
          "debugConsole.warningForeground" = colors.yellow;
          "debugConsole.errorForeground" = colors.red;
          "debugConsoleLink.foreground" = colors.blue;

          # -- terminal (UI)
          "terminal.background" = colors.background;
          "terminal.foreground" = colors.foreground;
          "terminal.border" = colors.transparent;
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
          "editorHoverWidget.border" = colors.transparent;

          # -- suggest / completion popup (style text + selection)
          "suggestWidget.background" = colors.background;
          "suggestWidget.foreground" = colors.foreground;
          "suggestWidget.border" = colors.transparent;

          "suggestWidget.selectedBackground" = colors.selection;
          "suggestWidget.selectedForeground" = colors.foreground;

          "suggestWidget.highlightForeground" = colors.yellow; # matched text color
          "suggestWidget.detailForeground" = colors.comment; # secondary text (module, return types)
          "suggestWidget.documentationFontSize" = 12;

          # sometimes VS Code uses editorSuggest* tokens too
          "editorSuggestWidget.background" = colors.background;
          "editorSuggestWidget.border" = colors.transparent;
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
          "menu.selectionBackground" = colors.selection; # top panel menu selection -> green
          "menu.selectionForeground" = colors.foreground;
          "menu.separatorBackground" = colors.line;
          "menu.border" = colors.transparent;

          "menubar.background" = colors.background;
          "menubar.foreground" = colors.foreground;
          "menubar.selectionBackground" = colors.selection;
          "menubar.selectionForeground" = colors.foreground;
          "menubar.selectionBorder" = colors.transparent;

          # -- notifications
          "notifications.background" = colors.background;
          "notifications.foreground" = colors.foreground;
          "notifications.border" = colors.transparent;
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

          # ============================================================
          # list renderer (suggest widget, quick pick, search results)
          # ============================================================

          # -- base list backgrounds
          "list.hoverBackground" = colors.selection; # hover only
          "list.activeSelectionBackground" = colors.blue;
          "list.inactiveSelectionBackground" = colors.background;

          # -- list foregrounds (UNSELECTED)
          "list.foreground" = colors.comment; # untyped text
          "list.focusForeground" = colors.line;

          # -- typed / matched text (UNSELECTED)
          "list.highlightForeground" = colors.foreground;
          "list.focusHighlightForeground" = colors.background;

          # -- SELECTED row text
          "list.activeSelectionForeground" = colors.line; # untyped text
          "list.inactiveSelectionForeground" = colors.line;

          # -- icons inside selected row
          "list.activeSelectionIconForeground" = colors.background;

          # -- remove focus outline
          "list.focusOutline" = colors.transparent;

          # ============================================================
          # quick input renderer (shared by suggest widget internals)
          # ============================================================

          "quickInput.background" = colors.background;
          "quickInput.foreground" = colors.comment; # untyped text baseline

          # -- focused (selected) entry
          "quickInputList.focusBackground" = colors.yellow;
          "quickInputList.focusForeground" = colors.line;
          "quickInputList.focusIconForeground" = colors.background;

          # ============================================================
          # fallback paths (kill default VS Code blue)
          # ============================================================

          # -- some completion providers still route here
          # "editorSuggestWidget.highlightForeground" = colors.foreground;

          # -- completion kind / symbol text
          "symbolIcon.textForeground" = colors.blue;

          # ============================================================
          # shared tree visuals
          # ============================================================

          "tree.indentGuidesStroke" = colors.line;
        };

        # -- editor behavior
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        # ============================================================
        # -- syntax theming (textmate only, semantic disabled)
        # ============================================================

        "editor.semanticHighlighting.enabled" = false;

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            # --------------------------------------------------------
            # -- comments
            # --------------------------------------------------------
            {
              scope = "comment";
              settings.foreground = colors.comment;
            }

            # --------------------------------------------------------
            # -- strings
            # --------------------------------------------------------
            {
              scope = [
                "string"
                "string.quoted"
                "string.template"
                "string.interpolated"
              ];
              settings.foreground = colors.green;
            }

            # --------------------------------------------------------
            # -- numbers
            # --------------------------------------------------------
            {
              scope = "constant.numeric";
              settings.foreground = colors.orange;
            }

            # --------------------------------------------------------
            # -- booleans / null
            # --------------------------------------------------------
            {
              scope = [
                "constant.language.boolean"
                "constant.language.true"
                "constant.language.false"
                "constant.language.null"
              ];
              settings.foreground = colors.purple;
            }

            # --------------------------------------------------------
            # -- keywords (generic)s
            # --------------------------------------------------------
            {
              scope = "keyword";
              settings.foreground = colors.purple;
            }

            # --------------------------------------------------------
            # -- operators
            # --------------------------------------------------------
            {
              scope = "keyword.operator";
              settings.foreground = colors.purple;
            }

            # --------------------------------------------------------
            # -- functions (generic)
            # --------------------------------------------------------
            {
              scope = [
                "entity.name.function"
                "support.function"
              ];
              settings.foreground = colors.blue;
            }

            # --------------------------------------------------------
            # -- types / classes / structs
            # --------------------------------------------------------
            {
              scope = [
                "entity.name.type"
                "storage.type"
                "support.type"
              ];
              settings.foreground = colors.yellow;
            }

            # --------------------------------------------------------
            # -- variables / parameters
            # --------------------------------------------------------
            {
              scope = [
                "variable"
                "variable.parameter"
                "variable.other.readwrite"
              ];
              settings.foreground = colors.foreground;
            }

            # --------------------------------------------------------
            # -- attributes / properties / object keys
            # --------------------------------------------------------
            {
              scope = [
                "variable.other.object.property"
                "entity.other.attribute-name"
                "entity.name.tag"
              ];
              settings.foreground = colors.foreground;
            }

            # --------------------------------------------------------
            # -- punctuation (base)
            # --------------------------------------------------------
            {
              scope = "punctuation";
              settings.foreground = colors.comment;
            }

            # --------------------------------------------------------
            # -- brackets (force single color everywhere)
            # --------------------------------------------------------
            {
              scope = [
                "punctuation.section.brackets"
                "punctuation.section.parens"
                "punctuation.section.block"
                "punctuation.definition.brackets"
                "punctuation.definition.parameters"
              ];
              settings.foreground = colors.blue;
            }

            # ========================================================
            # -- nix
            # ========================================================
            {
              scope = "source.nix";
              settings.foreground = colors.foreground;
            }
            {
              scope = [
                "keyword.other.nix"
                "keyword.control.nix"
                "keyword.operator.nix"
                "storage.type.nix"
              ];
              settings.foreground = colors.purple;
            }
            {
              scope = [
                "entity.name.function.nix"
                "support.function.builtin.nix"
              ];
              settings.foreground = colors.blue;
            }
            {
              scope = [
                "entity.other.attribute-name.multipart.nix"
                "entity.name.attribute-name.nix"
                "variable.other.constant.nix"
                "meta.attribute-set.nix"
              ];
              settings.foreground = colors.foreground;
            }
            {
              scope = "support.constant.nix";
              settings.foreground = colors.yellow;
            }

            # ========================================================
            # -- shell / bash
            # ========================================================
            {
              scope = "source.shell keyword";
              settings.foreground = colors.purple;
            }
            {
              scope = "source.shell variable";
              settings.foreground = colors.foreground;
            }
            {
              scope = "source.shell support.function";
              settings.foreground = colors.blue;
            }

            # ========================================================
            # -- python
            # ========================================================
            {
              scope = "source.python keyword";
              settings.foreground = colors.purple;
            }
            {
              scope = "entity.name.function.python";
              settings.foreground = colors.blue;
            }
            {
              scope = "storage.type.function.python";
              settings.foreground = colors.purple;
            }

            # ========================================================
            # -- c / c++
            # ========================================================
            {
              scope = [
                "source.c keyword"
                "source.cpp keyword"
              ];
              settings.foreground = colors.purple;
            }
            {
              scope = [
                "entity.name.function.c"
                "entity.name.function.cpp"
              ];
              settings.foreground = colors.blue;
            }
            {
              scope = [
                "storage.type.c"
                "storage.type.cpp"
              ];
              settings.foreground = colors.yellow;
            }

            # ========================================================
            # -- javascript / typescript
            # ========================================================
            {
              scope = [
                "source.js keyword"
                "source.ts keyword"
              ];
              settings.foreground = colors.purple;
            }
            {
              scope = [
                "entity.name.function.js"
                "entity.name.function.ts"
              ];
              settings.foreground = colors.blue;
            }

            # ========================================================
            # -- json
            # ========================================================
            {
              scope = "source.json entity.name.section";
              settings.foreground = colors.yellow;
            }

            # ========================================================
            # -- yaml
            # ========================================================
            {
              scope = "source.yaml key";
              settings.foreground = colors.yellow;
            }

            # ========================================================
            # -- toml
            # ========================================================
            {
              scope = "source.toml entity.name.section";
              settings.foreground = colors.yellow;
            }

            # ========================================================
            # -- css / html
            # ========================================================
            {
              scope = [
                "source.css support.type.property-name"
                "source.css entity.name.tag"
              ];
              settings.foreground = colors.purple;
            }
            {
              scope = [
                "text.html.basic entity.name.tag"
                "text.html.basic entity.other.attribute-name"
              ];
              settings.foreground = colors.yellow;
            }

            # --------------------------------------------------------
            # -- fallback
            # --------------------------------------------------------
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
