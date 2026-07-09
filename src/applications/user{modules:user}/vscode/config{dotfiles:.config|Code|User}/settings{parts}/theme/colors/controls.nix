{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "button.background" = palette.dark-gray;
    "button.border" = invisible;
    "button.foreground" = palette.white;
    "button.hoverBackground" = palette.dim-gray;
    "button.secondaryBackground" = invisible;
    "button.secondaryForeground" = palette.white;
    "button.secondaryHoverBackground" = palette.dark-gray;

    "extensionButton.background" = palette.dark-gray;
    "extensionButton.foreground" = palette.white;
    "extensionButton.hoverBackground" = palette.dim-gray;
    "extensionButton.prominentBackground" = palette.dark-gray;
    "extensionButton.prominentForeground" = palette.white;
    "extensionButton.prominentHoverBackground" = palette.blue;
    "extensionButton.separator" = palette.gray;

    "checkbox.background" = palette.dark-gray;
    "checkbox.border" = palette.dark-gray;
    "checkbox.foreground" = palette.light-gray;

    "badge.background" = palette.dark-gray;
    "badge.foreground" = palette.white;

    "activityErrorBadge.background" = palette.red;
    "activityErrorBadge.foreground" = palette.black;

    "activityWarningBadge.background" = palette.yellow;
    "activityWarningBadge.foreground" = palette.white;

    "progressBar.background" = palette.blue;

    "actionBar.toggledBackground" = palette.dim-gray;
  };
}
