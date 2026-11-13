{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "button.background" = palette.neutral-800;
    "button.border" = invisible;
    "button.foreground" = palette.neutral-0;
    "button.hoverBackground" = palette.neutral-600;
    "button.secondaryBackground" = invisible;
    "button.secondaryForeground" = palette.neutral-0;
    "button.secondaryHoverBackground" = palette.neutral-800;

    "extensionButton.background" = palette.neutral-800;
    "extensionButton.foreground" = palette.neutral-0;
    "extensionButton.hoverBackground" = palette.neutral-600;
    "extensionButton.prominentBackground" = palette.neutral-800;
    "extensionButton.prominentForeground" = palette.neutral-0;
    "extensionButton.prominentHoverBackground" = palette.blue;
    "extensionButton.separator" = palette.neutral-400;

    "checkbox.background" = palette.neutral-800;
    "checkbox.border" = palette.neutral-800;
    "checkbox.foreground" = palette.neutral-200;

    "badge.background" = palette.neutral-800;
    "badge.foreground" = palette.neutral-0;

    "activityErrorBadge.background" = palette.red;
    "activityErrorBadge.foreground" = palette.neutral-1000;

    "activityWarningBadge.background" = palette.yellow;
    "activityWarningBadge.foreground" = palette.neutral-0;

    "progressBar.background" = palette.blue;

    "actionBar.toggledBackground" = palette.neutral-600;
  };
}
