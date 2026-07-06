{file-dir, ...}: let
  parts-dir = "${file-dir}/settings-parts{x}";
  invisible = "#ffffff00";

  palette = {
    black = "#1d1f21";
    dark-gray = "#282a2e";
    dim-gray = "#373b41";
    gray = "#4d5057";
    light-gray = "#969896";
    white = "#c5c8c6";
    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";
  };

  tool-settings = import "${parts-dir}/tool-settings.nix" {};
  behaviour = import "${parts-dir}/behaviour.nix" {};
  appearance = import "${parts-dir}/theme/appearance.nix" {
    inherit parts-dir;
  };
in
  behaviour
  // tool-settings
  // appearance
  // {
    "workbench.colorCustomizations" = {
      # -- editor
      "editor.background" = palette.black;
      "editor.foreground" = palette.white;

      "editor.selectionBackground" = palette.dim-gray;
      "editor.selectionForeground" = palette.white;
      "editor.selectionHighlightBackground" = palette.dim-gray;
      "editor.selectionHighlightBorder" = invisible;

      "editor.lineHighlightBackground" = palette.dark-gray;

      "editorCursor.foreground" = palette.white;
      "editorLineNumber.foreground" = palette.gray;
      "editorLineNumber.activeForeground" = palette.white;

      "focusBorder" = invisible;
      "contrastBorder" = invisible;

      # -- activity-bar
      "activityBar.background" = palette.black;
      "activityBar.foreground" = palette.white;
      "activityBar.inactiveForeground" = palette.light-gray;
      "activityBar.border" = invisible;
      "activityBar.activeBorder" = invisible;
      "activityBar.activeFocusBorder" = invisible;

      # -- sidebar
      "sideBar.background" = palette.black;
      "sideBar.foreground" = palette.white;
      "sideBar.border" = palette.dark-gray;

      # -- tabs
      "tab.activeBackground" = palette.dark-gray;
      "tab.activeForeground" = palette.white;

      "tab.inactiveBackground" = palette.black;
      "tab.inactiveForeground" = palette.light-gray;

      "tab.inactiveBorder" = invisible;
      "tab.unfocusedInactiveBorder" = invisible;
      "tab.activeBorderTop" = invisible;
      "tab.unfocusedActiveBorderTop" = invisible;
      "tab.selectedBorderTop" = invisible;
      "tab.border" = invisible;
      "tab.activeBorder" = invisible;
      "tab.unfocusedActiveBorder" = invisible;
      "tab.activeModifiedBorder" = invisible;

      "tab.activeModifiedForeground" = palette.black;
      "tab.inactiveModifiedForeground" = palette.light-gray;

      "problems.decorations.enabled" = false;
      "scm.diffDecorations" = "none";

      # -- titlebar / command-center
      "titleBar.activeBackground" = palette.black;
      "titleBar.activeForeground" = palette.white;
      "titleBar.inactiveBackground" = palette.black;
      "titleBar.inactiveForeground" = palette.light-gray;
      "titleBar.border" = invisible;

      "commandCenter.background" = palette.dark-gray;
      "commandCenter.foreground" = palette.white;
      "commandCenter.border" = invisible;
      "commandCenter.activeBackground" = palette.dim-gray;
      "commandCenter.activeForeground" = palette.white;

      # -- panels / inputs
      "panel.background" = palette.black;
      "panel.border" = palette.dark-gray;
      "panelTitle.activeForeground" = palette.white;
      "panelTitle.inactiveForeground" = palette.light-gray;

      "input.background" = palette.dark-gray;
      "input.foreground" = palette.white;
      "input.border" = palette.dark-gray;

      "dropdown.background" = palette.dark-gray;
      "dropdown.foreground" = palette.white;
      "dropdown.border" = palette.dark-gray;

      # -- scrollbar
      "scrollbar.shadow" = invisible;
      "scrollbarSlider.background" = "${palette.gray}99";
      "scrollbarSlider.hoverBackground" = "${palette.light-gray}cc";
      "scrollbarSlider.activeBackground" = palette.white;

      # -- git
      "gitDecoration.modifiedResourceForeground" = palette.yellow;
      "gitDecoration.addedResourceForeground" = palette.green;
      "gitDecoration.deletedResourceForeground" = palette.red;
      "gitDecoration.untrackedResourceForeground" = palette.aqua;
      "gitDecoration.ignoredResourceForeground" = palette.light-gray;
      "gitDecoration.renamedResourceForeground" = palette.aqua;

      # -- gutter / overview
      "editorGutter.addedBackground" = palette.green;
      "editorGutter.modifiedBackground" = palette.yellow;
      "editorGutter.deletedBackground" = palette.red;

      "editorOverviewRuler.addedForeground" = "${palette.green}99";
      "editorOverviewRuler.modifiedForeground" = "${palette.yellow}99";
      "editorOverviewRuler.deletedForeground" = "${palette.red}99";
      "editorOverviewRuler.commonContentForeground" = "${palette.gray}99";
      "editorOverviewRuler.warningForeground" = palette.orange;

      # -- diagnostics
      "editorError.foreground" = palette.red;
      "editorWarning.foreground" = palette.orange;
      "editorInfo.foreground" = palette.white;
      "editorHint.foreground" = palette.light-gray;

      "editor.errorDecoration" = "underline";
      "editor.warningDecoration" = "underline";
      "editor.infoDecoration" = "underline";

      # -- search
      "editor.findMatchForeground" = palette.black;
      "editor.findMatchBackground" = palette.green;
      "editor.findMatchBorder" = invisible;

      "editor.findMatchHighlightForeground" = palette.black;
      "editor.findMatchHighlightBackground" = palette.white;
      "editor.findMatchHighlightBorder" = invisible;

      # -- debug
      "debugToolBar.background" = palette.dark-gray;
      "debugToolBar.border" = invisible;

      "textLink.foreground" = palette.blue;
      "textLink.activeForeground" = palette.blue;
      "textLink.border" = invisible;

      "debugConsole.infoForeground" = palette.blue;
      "debugConsole.warningForeground" = palette.yellow;
      "debugConsole.errorForeground" = palette.red;
      "debugConsoleLink.foreground" = palette.blue;

      # -- terminal
      "terminal.background" = palette.black;
      "terminal.foreground" = palette.white;
      "terminal.border" = palette.dark-gray;
      "terminal.selectionBackground" = palette.dim-gray;

      "terminal.tab.activeBackground" = palette.dark-gray;
      "terminal.tab.activeForeground" = palette.white;
      "terminal.tab.inactiveBackground" = palette.black;
      "terminal.tab.inactiveForeground" = palette.light-gray;
      "terminal.tab.activeBorder" = palette.dark-gray;
      "terminal.tab.activeBorderTop" = palette.dark-gray;
      "terminal.tab.activeIconForeground" = invisible;
      "terminal.tab.inactiveIconForeground" = invisible;

      "terminal.ansiBlack" = palette.light-gray;
      "terminal.ansiRed" = palette.red;
      "terminal.ansiGreen" = palette.green;
      "terminal.ansiYellow" = palette.yellow;
      "terminal.ansiBlue" = palette.blue;
      "terminal.ansiMagenta" = palette.purple;
      "terminal.ansiCyan" = palette.aqua;
      "terminal.ansiWhite" = palette.white;

      "terminal.ansiBrightBlack" = palette.light-gray;
      "terminal.ansiBrightRed" = palette.red;
      "terminal.ansiBrightGreen" = palette.green;
      "terminal.ansiBrightYellow" = palette.yellow;
      "terminal.ansiBrightBlue" = palette.blue;
      "terminal.ansiBrightMagenta" = palette.purple;
      "terminal.ansiBrightCyan" = palette.aqua;
      "terminal.ansiBrightWhite" = palette.white;

      # -- hover
      "editor.wordHighlightBackground" = "${palette.blue}2E";
      "editor.wordHighlightStrongBackground" = "${palette.blue}2E";

      "editorHoverWidget.background" = palette.dark-gray;
      "editorHoverWidget.foreground" = palette.white;
      "editorHoverWidget.border" = invisible;

      # -- suggest
      "suggestWidget.background" = palette.black;
      "suggestWidget.foreground" = palette.white;
      "suggestWidget.border" = palette.dark-gray;

      "suggestWidget.selectedBackground" = palette.dim-gray;
      "suggestWidget.selectedForeground" = palette.white;

      "suggestWidget.highlightForeground" = palette.green;
      "suggestWidget.detailForeground" = palette.white;
      "suggestWidget.documentationFontSize" = 12;

      "suggestWidgetScrollbarSlider.background" = palette.gray;
      "suggestWidgetScrollbarSlider.hoverBackground" = palette.light-gray;
      "suggestWidgetScrollbarSlider.activeBackground" = palette.white;

      # -- buttons
      "button.background" = palette.dark-gray;
      "button.foreground" = palette.white;
      "button.hoverBackground" = palette.dim-gray;
      "button.border" = invisible;

      "button.secondaryBackground" = invisible;
      "button.secondaryForeground" = palette.white;

      "badge.background" = palette.dark-gray;
      "badge.foreground" = palette.white;

      "extensionButton.background" = palette.dark-gray;
      "extensionButton.foreground" = palette.white;
      "extensionButton.hoverBackground" = palette.dim-gray;
      "extensionButton.prominentBackground" = palette.dark-gray;
      "extensionButton.prominentForeground" = palette.white;
      "extensionButton.separator" = palette.gray;

      # -- menus
      "menu.background" = palette.black;
      "menu.foreground" = palette.white;
      "menu.selectionBackground" = palette.dim-gray;
      "menu.selectionForeground" = palette.white;
      "menu.separatorBackground" = palette.dark-gray;
      "menu.border" = palette.dark-gray;

      "menubar.background" = palette.black;
      "menubar.foreground" = palette.white;
      "menubar.selectionBackground" = palette.dim-gray;
      "menubar.selectionForeground" = palette.white;
      "menubar.selectionBorder" = invisible;

      # -- notifications
      "notifications.background" = palette.black;
      "notifications.foreground" = palette.white;
      "notifications.border" = palette.dark-gray;

      "notificationLink.foreground" = palette.blue;
      "notificationsInfoIcon.foreground" = palette.blue;
      "notificationsErrorIcon.foreground" = palette.red;
      "notificationsWarningIcon.foreground" = palette.orange;

      # -- breadcrumbs
      "breadcrumb.background" = palette.black;
      "breadcrumb.foreground" = palette.light-gray;
      "breadcrumb.focusForeground" = palette.white;
      "breadcrumb.activeSelectionForeground" = palette.white;

      # -- diff
      "diffEditor.insertedTextBackground" = "${palette.green}33";
      "diffEditor.removedTextBackground" = "${palette.red}33";

      # -- brackets
      "editorBracketMatch.background" = invisible;
      "editorBracketMatch.border" = invisible;

      "editorBracketHighlight.foreground1" = palette.light-gray;
      "editorBracketHighlight.foreground2" = palette.light-gray;
      "editorBracketHighlight.foreground3" = palette.light-gray;
      "editorBracketHighlight.foreground4" = palette.light-gray;
      "editorBracketHighlight.foreground5" = palette.light-gray;
      "editorBracketHighlight.foreground6" = palette.light-gray;

      "editorBracketPairGuide.activeBackground1" = invisible;
      "editorBracketPairGuide.activeBackground2" = invisible;
      "editorBracketPairGuide.activeBackground3" = invisible;
      "editorBracketPairGuide.activeBackground4" = invisible;
      "editorBracketPairGuide.activeBackground5" = invisible;
      "editorBracketPairGuide.activeBackground6" = invisible;

      "editorBracketPairGuide.background1" = invisible;
      "editorBracketPairGuide.background2" = invisible;
      "editorBracketPairGuide.background3" = invisible;
      "editorBracketPairGuide.background4" = invisible;
      "editorBracketPairGuide.background5" = invisible;
      "editorBracketPairGuide.background6" = invisible;

      "editor.guides.bracketPairs" = palette.dim-gray;
      "editor.guides.bracketPairsActive" = palette.dim-gray;

      # -- lists
      "list.activeSelectionBackground" = palette.dim-gray;
      "list.activeSelectionForeground" = palette.white;
      "list.activeSelectionIconForeground" = palette.green;

      "list.inactiveSelectionBackground" = palette.dark-gray;
      "list.inactiveSelectionForeground" = palette.white;

      "list.hoverBackground" = palette.dark-gray;

      "list.foreground" = palette.white;
      "list.focusForeground" = palette.white;

      "list.focusOutline" = invisible;

      "tree.indentGuidesStroke" = palette.white;

      # -- suggest-internal
      "list.highlightForeground" = palette.white;
      "list.focusHighlightForeground" = palette.green;

      "editorSuggestWidget.background" = palette.black;
      "editorSuggestWidget.foreground" = palette.white;
      "editorSuggestWidget.border" = palette.dark-gray;

      "editorSuggestWidget.highlightForeground" = palette.white;

      "editorSuggestWidget.selectedBackground" = palette.dark-gray;
      "editorSuggestWidget.selectedForeground" = palette.green;

      "symbolIcon.textForeground" = palette.white;
    };
  }
