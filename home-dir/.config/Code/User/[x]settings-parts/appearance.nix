{config, ...}: {
  # -- appearance
  "editor.fontFamily" = config.style.font.propo;
  "editor.fontLigatures" = true;
  "workbench.colorTheme" = "Default Dark Modern";
  "workbench.iconTheme" = "vs-seti";

  # -- cursor
  "editor.cursorStyle" = "line";
  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = "on";

  # -- layout
  "editor.minimap.enabled" = false;
  "workbench.tree.indent" = 20;

  # -- window
  "window.titleBarStyle" = "custom";
  "window.menuBarVisibility" = "classic";
}
