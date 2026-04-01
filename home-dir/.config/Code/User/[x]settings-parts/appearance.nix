{config, ...}: {
  # ============================================================
  # -- fonts and cursor
  # ============================================================

  "editor.fontFamily" = config.style.font.propo;
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
}
