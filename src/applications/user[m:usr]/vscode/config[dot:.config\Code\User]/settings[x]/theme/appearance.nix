{design-tokens, ...}: {
  # -- appearance
  "editor.fontFamily" = design-tokens.font.family.propo;
  "editor.fontLigatures" = true;
  "terminal.integrated.fontFamily" = design-tokens.font.family.mono;
  "workbench.colorTheme" = "Dark Modern";
  "workbench.iconTheme" = "vscode-icon-theme";
  "workbench.productIconTheme" = "fluent-icons";

  # -- cursor
  "editor.cursorStyle" = "line";
  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = "on";

  # -- layout
  "editor.minimap.enabled" = false;
  "workbench.tree.indent" = 20;
  "editor.bracketPairColorization.enabled" = true;
  "editor.guides.bracketPairs" = true;

  # -- window
  "window.titleBarStyle" = "custom";
  "window.menuBarVisibility" = "classic";

  # -- syntax theming
  "editor.semanticHighlighting.enabled" = false;
}
