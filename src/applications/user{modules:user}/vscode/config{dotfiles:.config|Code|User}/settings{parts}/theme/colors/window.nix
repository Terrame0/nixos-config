{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "breadcrumb.activeSelectionForeground" = palette.white;
    "breadcrumb.background" = palette.black;
    "breadcrumb.focusForeground" = palette.white;
    "breadcrumb.foreground" = palette.light-gray;

    "breadcrumbPicker.background" = palette.black;

    "commandCenter.activeBackground" = palette.dim-gray;
    "commandCenter.activeBorder" = palette.dark-gray;
    "commandCenter.activeForeground" = palette.white;
    "commandCenter.background" = palette.dark-gray;
    "commandCenter.border" = invisible;
    "commandCenter.foreground" = palette.white;

    "menu.background" = palette.black;
    "menu.border" = palette.dark-gray;
    "menu.foreground" = palette.white;
    "menu.selectionBackground" = palette.dim-gray;
    "menu.selectionForeground" = palette.white;
    "menu.separatorBackground" = palette.dark-gray;

    "menubar.background" = palette.black;
    "menubar.foreground" = palette.white;
    "menubar.selectionBackground" = palette.dim-gray;
    "menubar.selectionBorder" = invisible;
    "menubar.selectionForeground" = palette.white;

    "notificationCenter.border" = palette.dark-gray;

    "notificationCenterHeader.background" = palette.black;
    "notificationCenterHeader.foreground" = palette.white;

    "notificationLink.foreground" = palette.blue;

    "notificationToast.border" = palette.dark-gray;

    "notifications.background" = palette.black;
    "notifications.border" = palette.dark-gray;
    "notifications.foreground" = palette.white;

    "notificationsErrorIcon.foreground" = palette.red;

    "notificationsInfoIcon.foreground" = palette.blue;

    "notificationsWarningIcon.foreground" = palette.orange;

    "statusBar.background" = palette.black;
    "statusBar.border" = palette.black;
    "statusBar.debuggingBackground" = palette.blue;
    "statusBar.debuggingForeground" = palette.black;
    "statusBar.focusBorder" = palette.blue;
    "statusBar.foreground" = palette.white;
    "statusBar.noFolderBackground" = palette.black;
    "statusBar.noFolderForeground" = palette.light-gray;

    "statusBarItem.activeBackground" = palette.dark-gray;
    "statusBarItem.compactHoverBackground" = palette.dim-gray;
    "statusBarItem.errorBackground" = palette.red;
    "statusBarItem.focusBorder" = palette.blue;
    "statusBarItem.hoverBackground" = palette.dim-gray;
    "statusBarItem.hoverForeground" = palette.white;
    "statusBarItem.prominentBackground" = "${palette.blue}dd";
    "statusBarItem.prominentForeground" = palette.black;
    "statusBarItem.prominentHoverBackground" = palette.blue;
    "statusBarItem.prominentHoverForeground" = palette.black;
    "statusBarItem.remoteBackground" = palette.blue;
    "statusBarItem.remoteForeground" = palette.black;

    "titleBar.activeBackground" = palette.black;
    "titleBar.activeForeground" = palette.white;
    "titleBar.border" = invisible;
    "titleBar.inactiveBackground" = palette.black;
    "titleBar.inactiveForeground" = palette.light-gray;
  };
}
