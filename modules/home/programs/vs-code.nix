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
      # ============================================================
      # -- extensions
      # ============================================================

      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        jnoortheen.nix-ide
        charliermarsh.ruff
        mads-hartmann.bash-ide-vscode
        llvm-vs-code-extensions.vscode-clangd
        ecmel.vscode-html-css
      ];

      # ============================================================
      # -- user settings
      # ============================================================

      userSettings = {
        # ============================================================
        # -- misc behavior
        # ============================================================

        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.untrustedFiles" = "open";
        "telemetry.telemetryLevel" = "off";
        "chat.disableAIFeatures" = true;

        # ============================================================
        # -- updates and recommendations
        # ============================================================

        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "extensions.ignoreRecommendations" = true;

        # ============================================================
        # -- startup and welcome
        # ============================================================

        "workbench.startupEditor" = "none";
        "workbench.welcome.enabled" = false;
        "workbench.tips.enabled" = false;
        "workbench.enableExperiments" = false;

        # ============================================================
        # -- fonts and cursor
        # ============================================================

        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.cursorStyle" = "line";
        "editor.cursorBlinking" = "solid";
        "editor.cursorSmoothCaretAnimation" = "on";

        # ============================================================
        # -- layout
        # ============================================================

        "editor.minimap.enabled" = false;
        "workbench.tree.indent" = 20;
        "workbench.colorTheme" = "Default Dark Modern";
        "workbench.iconTheme" = "vs-seti";

        # ============================================================
        # -- window and titlebar
        # ============================================================

        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "classic";

        # ============================================================
        # -- ui theming
        # ============================================================

        "workbench.colorCustomizations" = {
          # ----------------------------------------------------------
          # -- editor core
          # ----------------------------------------------------------

          "editor.background" = colors.background;
          "editor.foreground" = colors.foreground;

          "editor.selectionBackground" = colors.selection;
          "editor.selectionForeground" = colors.foreground;
          "editor.selectionHighlightBackground" = colors.selection;
          "editor.selectionHighlightBorder" = colors.transparent;

          "editor.lineHighlightBackground" = colors.line;

          "editorCursor.foreground" = colors.foreground;
          "editorLineNumber.foreground" = colors.window;
          "editorLineNumber.activeForeground" = colors.foreground;

          "focusBorder" = colors.transparent;
          "contrastBorder" = colors.transparent;

          # ----------------------------------------------------------
          # -- activity bar
          # ----------------------------------------------------------

          "activityBar.background" = colors.background;
          "activityBar.foreground" = colors.foreground;
          "activityBar.inactiveForeground" = colors.comment;
          "activityBar.border" = colors.transparent;
          "activityBar.activeBorder" = colors.transparent;
          "activityBar.activeFocusBorder" = colors.transparent;

          # ----------------------------------------------------------
          # -- sidebar and explorer
          # ----------------------------------------------------------

          "sideBar.background" = colors.background;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.transparent;

          # ----------------------------------------------------------
          # -- tabs
          # ----------------------------------------------------------

          "tab.activeBackground" = colors.line;
          "tab.activeForeground" = colors.foreground;

          "tab.inactiveBackground" = colors.background;
          "tab.inactiveForeground" = colors.comment;

          "tab.inactiveBorder" = colors.transparent;
          "tab.unfocusedInactiveBorder" = colors.transparent;
          "tab.activeBorderTop" = colors.transparent;
          "tab.unfocusedActiveBorderTop" = colors.transparent;
          "tab.selectedBorderTop" = colors.transparent;
          "tab.border" = colors.transparent;
          "tab.activeBorder" = colors.transparent;
          "tab.unfocusedActiveBorder" = colors.transparent;
          "tab.activeModifiedBorder" = colors.transparent;

          "tab.activeModifiedForeground" = colors.background;
          "tab.inactiveModifiedForeground" = colors.comment;

          "problems.decorations.enabled" = false;
          "scm.diffDecorations" = "none";

          # ----------------------------------------------------------
          # -- title bar and command center
          # ----------------------------------------------------------

          "titleBar.activeBackground" = colors.background;
          "titleBar.activeForeground" = colors.foreground;
          "titleBar.inactiveBackground" = colors.background;
          "titleBar.inactiveForeground" = colors.comment;
          "titleBar.border" = colors.transparent;

          "commandCenter.background" = colors.line;
          "commandCenter.foreground" = colors.foreground;
          "commandCenter.border" = colors.transparent;
          "commandCenter.activeBackground" = colors.selection;
          "commandCenter.activeForeground" = colors.foreground;

          # ----------------------------------------------------------
          # -- panels and inputs
          # ----------------------------------------------------------

          "panel.background" = colors.background;
          "panel.border" = colors.transparent;
          "panelTitle.activeForeground" = colors.foreground;
          "panelTitle.inactiveForeground" = colors.comment;

          "input.background" = colors.line;
          "input.foreground" = colors.foreground;
          "input.border" = colors.transparent;

          "dropdown.background" = colors.line;
          "dropdown.foreground" = colors.foreground;
          "dropdown.border" = colors.transparent;

          # ----------------------------------------------------------
          # -- scrollbar
          # ----------------------------------------------------------

          "scrollbar.shadow" = colors.transparent;
          "scrollbarSlider.background" = "${colors.window}99";
          "scrollbarSlider.hoverBackground" = "${colors.comment}cc";
          "scrollbarSlider.activeBackground" = colors.foreground;

          # ----------------------------------------------------------
          # -- git decorations
          # ----------------------------------------------------------

          "gitDecoration.modifiedResourceForeground" = colors.yellow;
          "gitDecoration.addedResourceForeground" = colors.green;
          "gitDecoration.deletedResourceForeground" = colors.red;
          "gitDecoration.untrackedResourceForeground" = colors.aqua;
          "gitDecoration.ignoredResourceForeground" = colors.comment;
          "gitDecoration.renamedResourceForeground" = colors.aqua;

          # ----------------------------------------------------------
          # -- gutter and overview ruler
          # ----------------------------------------------------------

          "editorGutter.addedBackground" = colors.green;
          "editorGutter.modifiedBackground" = colors.yellow;
          "editorGutter.deletedBackground" = colors.red;

          "editorOverviewRuler.addedForeground" = "${colors.green}99";
          "editorOverviewRuler.modifiedForeground" = "${colors.yellow}99";
          "editorOverviewRuler.deletedForeground" = "${colors.red}99";
          "editorOverviewRuler.commonContentForeground" = "${colors.window}99";
          "editorOverviewRuler.warningForeground" = colors.orange;

          # ----------------------------------------------------------
          # -- diagnostics
          # ----------------------------------------------------------

          "editorError.foreground" = colors.red;
          "editorWarning.foreground" = colors.orange;
          "editorInfo.foreground" = colors.foreground;
          "editorHint.foreground" = colors.comment;

          "editor.errorDecoration" = "underline";
          "editor.warningDecoration" = "underline";
          "editor.infoDecoration" = "underline";

          # ----------------------------------------------------------
          # -- search and find
          # ----------------------------------------------------------

          "editor.findMatchForeground" = colors.background;
          "editor.findMatchBackground" = colors.green;
          "editor.findMatchBorder" = colors.transparent;

          "editor.findMatchHighlightForeground" = colors.background;
          "editor.findMatchHighlightBackground" = colors.foreground;
          "editor.findMatchHighlightBorder" = colors.transparent;

          # ----------------------------------------------------------
          # -- welcome page
          # ----------------------------------------------------------

          "welcomePage.background" = colors.background;
          "welcomePage.tileBackground" = colors.line;
          "welcomePage.tileHoverBackground" = colors.selection;
          "welcomePage.tileBorder" = colors.transparent;
          "welcomePage.tileShadow" = colors.transparent;

          # ----------------------------------------------------------
          # -- debug
          # ----------------------------------------------------------

          "debugToolBar.background" = colors.line;
          "debugToolBar.border" = colors.transparent;

          "textLink.foreground" = colors.blue;
          "textLink.activeForeground" = colors.aqua;

          "debugConsole.infoForeground" = colors.blue;
          "debugConsole.warningForeground" = colors.yellow;
          "debugConsole.errorForeground" = colors.red;
          "debugConsoleLink.foreground" = colors.blue;

          # ----------------------------------------------------------
          # -- terminal
          # ----------------------------------------------------------

          "terminal.background" = colors.background;
          "terminal.foreground" = colors.foreground;
          "terminal.border" = colors.line;
          "terminal.selectionBackground" = colors.selection;

          "terminal.tab.activeBackground" = colors.line;
          "terminal.tab.activeForeground" = colors.foreground;
          "terminal.tab.inactiveBackground" = colors.background;
          "terminal.tab.inactiveForeground" = colors.comment;
          "terminal.tab.activeBorder" = colors.line;
          "terminal.tab.activeBorderTop" = colors.line;
          "terminal.tab.activeIconForeground" = colors.transparent;
          "terminal.tab.inactiveIconForeground" = colors.transparent;

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

          # ----------------------------------------------------------
          # -- hover and word highlight
          # ----------------------------------------------------------

          "editor.wordHighlightBackground" = colors.selection;
          "editor.wordHighlightStrongBackground" = colors.selection;

          "editorHoverWidget.background" = colors.line;
          "editorHoverWidget.foreground" = colors.foreground;
          "editorHoverWidget.border" = colors.transparent;

          # ----------------------------------------------------------
          # -- suggest widget
          # ----------------------------------------------------------

          "suggestWidget.background" = colors.background;
          "suggestWidget.foreground" = colors.foreground;
          "suggestWidget.border" = colors.line;

          "suggestWidget.selectedBackground" = colors.selection;
          "suggestWidget.selectedForeground" = colors.foreground;

          "suggestWidget.highlightForeground" = colors.green;
          "suggestWidget.detailForeground" = colors.foreground;
          "suggestWidget.documentationFontSize" = 12;

          "suggestWidgetScrollbarSlider.background" = colors.window;
          "suggestWidgetScrollbarSlider.hoverBackground" = colors.comment;
          "suggestWidgetScrollbarSlider.activeBackground" = colors.foreground;

          # ----------------------------------------------------------
          # -- buttons and badges
          # ----------------------------------------------------------

          "button.background" = colors.line;
          "button.foreground" = colors.foreground;
          "button.hoverBackground" = colors.selection;
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

          # ----------------------------------------------------------
          # -- menus
          # ----------------------------------------------------------

          "menu.background" = colors.background;
          "menu.foreground" = colors.foreground;
          "menu.selectionBackground" = colors.selection;
          "menu.selectionForeground" = colors.foreground;
          "menu.separatorBackground" = colors.line;
          "menu.border" = colors.transparent;

          "menubar.background" = colors.background;
          "menubar.foreground" = colors.foreground;
          "menubar.selectionBackground" = colors.selection;
          "menubar.selectionForeground" = colors.foreground;
          "menubar.selectionBorder" = colors.transparent;

          # ----------------------------------------------------------
          # -- notifications
          # ----------------------------------------------------------

          "notifications.background" = colors.background;
          "notifications.foreground" = colors.foreground;
          "notifications.border" = colors.transparent;

          "notificationLink.foreground" = colors.blue;
          "notificationsInfoIcon.foreground" = colors.blue;
          "notificationsErrorIcon.foreground" = colors.red;
          "notificationsWarningIcon.foreground" = colors.orange;

          # ----------------------------------------------------------
          # -- breadcrumbs
          # ----------------------------------------------------------

          "breadcrumb.background" = colors.background;
          "breadcrumb.foreground" = colors.comment;
          "breadcrumb.focusForeground" = colors.foreground;
          "breadcrumb.activeSelectionForeground" = colors.foreground;

          # ----------------------------------------------------------
          # -- diff editor
          # ----------------------------------------------------------

          "diffEditor.insertedTextBackground" = "${colors.green}33";
          "diffEditor.removedTextBackground" = "${colors.red}33";

          # ----------------------------------------------------------
          # -- brackets and guides
          # ----------------------------------------------------------

          "editorBracketMatch.background" = colors.transparent;
          "editorBracketMatch.border" = colors.transparent;

          "editorBracketHighlight.foreground1" = colors.aqua;
          "editorBracketHighlight.foreground2" = colors.aqua;
          "editorBracketHighlight.foreground3" = colors.aqua;
          "editorBracketHighlight.foreground4" = colors.aqua;
          "editorBracketHighlight.foreground5" = colors.aqua;
          "editorBracketHighlight.foreground6" = colors.aqua;
          "editorBracketHighlight.unexpectedBracket.foreground" = colors.red;

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

          "editor.guides.bracketPairs" = colors.selection;
          "editor.guides.bracketPairsActive" = colors.selection;

          # ----------------------------------------------------------
          # -- list renderer
          # ----------------------------------------------------------

          "list.activeSelectionBackground" = colors.selection;
          "list.activeSelectionForeground" = colors.foreground;
          "list.activeSelectionIconForeground" = colors.green;

          "list.inactiveSelectionBackground" = colors.line;
          "list.inactiveSelectionForeground" = colors.foreground;

          "list.hoverBackground" = colors.selection;

          "list.foreground" = colors.foreground;
          "list.focusForeground" = colors.foreground;

          "list.focusOutline" = colors.transparent;

          "tree.indentGuidesStroke" = colors.foreground;

          # ----------------------------------------------------------
          # -- suggestion widget internals
          # ----------------------------------------------------------

          "list.highlightForeground" = colors.foreground;
          "list.focusHighlightForeground" = colors.green;

          "editorSuggestWidget.background" = colors.background;
          "editorSuggestWidget.foreground" = colors.foreground;
          "editorSuggestWidget.border" = colors.line;

          "editorSuggestWidget.highlightForeground" = colors.foreground;

          "editorSuggestWidget.selectedBackground" = colors.line;
          "editorSuggestWidget.selectedForeground" = colors.green;

          "symbolIcon.textForeground" = colors.foreground;
        };

        # ============================================================
        # -- editor behavior
        # ============================================================

        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        # ============================================================
        # -- syntax theming
        # ============================================================

        "editor.semanticHighlighting.enabled" = false;

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            # -- comments
            {
              scope = "comment";
              settings.foreground = colors.comment;
            }

            # -- strings
            {
              scope = [
                "string"
                "string.quoted"
                "string.template"
                "string.interpolated"
              ];
              settings.foreground = colors.orange;
            }

            # -- numbers
            {
              scope = "constant.numeric";
              settings.foreground = colors.purple;
            }

            # -- booleans and null
            {
              scope = [
                "constant.language.boolean"
                "constant.language.true"
                "constant.language.false"
                "constant.language.null"
              ];
              settings.foreground = colors.purple;
            }

            # -- keywords
            {
              scope = "keyword";
              settings.foreground = colors.purple;
            }

            # -- operators
            {
              scope = "keyword.operator";
              settings.foreground = colors.aqua;
            }

            # -- functions
            {
              scope = [
                "entity.name.function"
                "support.function"
              ];
              settings.foreground = colors.orange;
            }

            # -- types
            {
              scope = [
                "entity.name.type"
                "storage.type"
                "support.type"
              ];
              settings.foreground = colors.blue;
            }

            # -- variables
            {
              scope = [
                "variable"
                "variable.parameter"
                "variable.other.readwrite"
              ];
              settings.foreground = colors.blue;
            }

            # -- attributes and properties
            {
              scope = [
                "variable.other.object.property"
                "entity.other.attribute-name"
                "entity.name.tag"
              ];
              settings.foreground = colors.yellow;
            }

            # -- punctuation
            {
              scope = "punctuation";
              settings.foreground = colors.comment;
            }

            # -- brackets
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

            # -- nix
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
              settings.foreground = colors.aqua;
            }

            {
              scope = [
                "entity.name.function.nix"
                "support.function.builtin.nix"
                "constant.language.nix"
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

            # -- shell
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

            # -- python
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

            # -- c and c plus plus
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

            # -- javascript and typescript
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

            # -- json
            {
              scope = "source.json entity.name.section";
              settings.foreground = colors.yellow;
            }

            # -- yaml
            {
              scope = "source.yaml key";
              settings.foreground = colors.yellow;
            }

            # -- toml
            {
              scope = "source.toml entity.name.section";
              settings.foreground = colors.yellow;
            }

            # -- css and html
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
