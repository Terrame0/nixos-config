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

          # -- activity bar
          "activityBar.background" = colors.background;
          "activityBar.foreground" = colors.foreground;
          "activityBar.inactiveForeground" = colors.comment;
          "activityBar.border" = colors.transparent;
          "activityBar.activeBorder" = colors.transparent;
          "activityBar.activeFocusBorder" = colors.transparent;

          # -- sidebar
          "sideBar.background" = colors.background;
          "sideBar.foreground" = colors.foreground;
          "sideBar.border" = colors.transparent;

          # -- explorer selection
          "list.activeSelectionBackground" = colors.green;
          "list.activeSelectionForeground" = colors.background;
          "list.activeSelectionIconForeground" = colors.background;
          "list.inactiveSelectionBackground" = colors.line;
          "list.inactiveSelectionForeground" = colors.foreground;
          "list.hoverBackground" = colors.selection;
          "list.focusOutline" = colors.transparent;
          "tree.indentGuidesStroke" = colors.line;

          # ============================================================
          # -- suggestion / completion fallback FIX (ONLY ADDITION)
          # ============================================================
          "list.foreground" = colors.foreground;
          "list.hoverForeground" = colors.foreground;

          "quickInput.background" = colors.background;
          "quickInput.foreground" = colors.foreground;
          "quickInputList.focusBackground" = colors.selection;
          "quickInputList.focusForeground" = colors.foreground;
          "quickInputList.focusIconForeground" = colors.foreground;

          "symbolIcon.textForeground" = colors.foreground;
          # ============================================================

          # -- tabs
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

          # -- title bar
          "titleBar.activeBackground" = colors.background;
          "titleBar.activeForeground" = colors.foreground;
          "titleBar.inactiveBackground" = colors.background;
          "titleBar.inactiveForeground" = colors.comment;
          "titleBar.border" = colors.transparent;

          # -- panels
          "panel.background" = colors.background;
          "panel.border" = colors.transparent;
          "panelTitle.activeForeground" = colors.foreground;
          "panelTitle.inactiveForeground" = colors.comment;

          # -- inputs
          "input.background" = colors.line;
          "input.foreground" = colors.foreground;
          "input.border" = colors.transparent;

          "dropdown.background" = colors.line;
          "dropdown.foreground" = colors.foreground;
          "dropdown.border" = colors.transparent;

          # -- scrollbars
          "scrollbar.shadow" = colors.transparent;
          "scrollbarSlider.background" = "${colors.window}99";
          "scrollbarSlider.hoverBackground" = "${colors.comment}cc";
          "scrollbarSlider.activeBackground" = colors.foreground;

          # -- hover
          "editorHoverWidget.background" = colors.line;
          "editorHoverWidget.foreground" = colors.foreground;
          "editorHoverWidget.border" = colors.transparent;

          # -- suggest widget (already styled)
          "suggestWidget.background" = colors.background;
          "suggestWidget.foreground" = colors.foreground;
          "suggestWidget.border" = colors.transparent;
          "suggestWidget.selectedBackground" = colors.selection;
          "suggestWidget.selectedForeground" = colors.foreground;
          "suggestWidget.highlightForeground" = colors.yellow;
          "suggestWidget.detailForeground" = colors.comment;

          "editorSuggestWidget.background" = colors.background;
          "editorSuggestWidget.border" = colors.transparent;
          "editorSuggestWidget.selectedForeground" = colors.foreground;
        };

        # ============================================================
        # -- syntax theming (unchanged)
        # ============================================================
        "editor.semanticHighlighting.enabled" = false;
      };
    };
  };
}
