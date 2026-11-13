{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "breadcrumb.activeSelectionForeground" = palette.neutral-0;
    "breadcrumb.background" = palette.neutral-1000;
    "breadcrumb.focusForeground" = palette.neutral-0;
    "breadcrumb.foreground" = palette.neutral-200;

    "breadcrumbPicker.background" = palette.neutral-1000;

    "commandCenter.activeBackground" = palette.neutral-600;
    "commandCenter.activeBorder" = palette.neutral-800;
    "commandCenter.activeForeground" = palette.neutral-0;
    "commandCenter.background" = palette.neutral-800;
    "commandCenter.border" = invisible;
    "commandCenter.foreground" = palette.neutral-0;

    "menu.background" = palette.neutral-1000;
    "menu.border" = palette.neutral-800;
    "menu.foreground" = palette.neutral-0;
    "menu.selectionBackground" = palette.neutral-600;
    "menu.selectionForeground" = palette.neutral-0;
    "menu.separatorBackground" = palette.neutral-800;

    "menubar.background" = palette.neutral-1000;
    "menubar.foreground" = palette.neutral-0;
    "menubar.selectionBackground" = palette.neutral-600;
    "menubar.selectionBorder" = invisible;
    "menubar.selectionForeground" = palette.neutral-0;

    "notificationCenter.border" = palette.neutral-800;

    "notificationCenterHeader.background" = palette.neutral-1000;
    "notificationCenterHeader.foreground" = palette.neutral-0;

    "notificationLink.foreground" = palette.blue;

    "notificationToast.border" = palette.neutral-800;

    "notifications.background" = palette.neutral-1000;
    "notifications.border" = palette.neutral-800;
    "notifications.foreground" = palette.neutral-0;

    "notificationsErrorIcon.foreground" = palette.red;

    "notificationsInfoIcon.foreground" = palette.blue;

    "notificationsWarningIcon.foreground" = palette.orange;

    "statusBar.background" = palette.neutral-1000;
    "statusBar.border" = palette.neutral-1000;
    "statusBar.debuggingBackground" = palette.blue;
    "statusBar.debuggingForeground" = palette.neutral-1000;
    "statusBar.focusBorder" = palette.blue;
    "statusBar.foreground" = palette.neutral-0;
    "statusBar.noFolderBackground" = palette.neutral-1000;
    "statusBar.noFolderForeground" = palette.neutral-200;

    "statusBarItem.activeBackground" = palette.neutral-800;
    "statusBarItem.compactHoverBackground" = palette.neutral-600;
    "statusBarItem.errorBackground" = palette.red;
    "statusBarItem.errorHoverBackground" = "${palette.red}cc";
    "statusBarItem.focusBorder" = palette.blue;
    "statusBarItem.hoverBackground" = palette.neutral-600;
    "statusBarItem.hoverForeground" = palette.neutral-0;
    "statusBarItem.prominentBackground" = "${palette.blue}dd";
    "statusBarItem.prominentForeground" = palette.neutral-1000;
    "statusBarItem.prominentHoverBackground" = palette.blue;
    "statusBarItem.prominentHoverForeground" = palette.neutral-1000;
    "statusBarItem.remoteBackground" = palette.blue;
    "statusBarItem.remoteForeground" = palette.neutral-1000;
    "statusBarItem.remoteHoverBackground" = "${palette.blue}cc";

    "titleBar.activeBackground" = palette.neutral-1000;
    "titleBar.activeForeground" = palette.neutral-0;
    "titleBar.border" = invisible;
    "titleBar.inactiveBackground" = palette.neutral-1000;
    "titleBar.inactiveForeground" = palette.neutral-200;
  };
}
