{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "panel.background" = palette.neutral-1000;
    "panel.border" = palette.neutral-800;

    "panelTitle.activeBorder" = invisible;
    "panelTitle.activeForeground" = palette.neutral-0;
    "panelTitle.inactiveForeground" = palette.neutral-200;

    "panelInput.border" = palette.neutral-800;
    "panelStickyScroll.shadow" = invisible;

    "input.background" = palette.neutral-800;
    "input.border" = palette.neutral-800;
    "input.foreground" = palette.neutral-0;
    "input.placeholderForeground" = palette.neutral-200;

    "inputOption.activeBackground" = "${palette.blue}26";
    "inputOption.activeBorder" = palette.neutral-800;
    "inputOption.activeForeground" = palette.neutral-0;
    "inputOption.hoverBackground" = palette.neutral-600;

    "dropdown.background" = palette.neutral-800;
    "dropdown.border" = palette.neutral-800;
    "dropdown.foreground" = palette.neutral-0;
    "dropdown.listBackground" = palette.neutral-800;

    "radio.activeBackground" = "${palette.orange}26";
    "radio.activeBorder" = palette.orange;
    "radio.activeForeground" = palette.neutral-0;
    "radio.inactiveHoverBackground" = palette.neutral-600;
  };
}
