{parts-dir, ...}: {
  # -- appearance
  "editor.fontFamily" = "JetBrainsMono NFP";
  "editor.fontLigatures" = true;
  "workbench.colorTheme" = "Dark Modern";
  "workbench.iconTheme" = "vs-seti";

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
  "editor.tokenColorCustomizations" = import "${parts-dir}/theme/textmate.nix" {};
}
