{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "titleBar.activeBackground" = palette.black;
    "titleBar.activeForeground" = palette.white;
    "titleBar.inactiveBackground" = palette.black;
    "titleBar.inactiveForeground" = palette.light-gray;
    "titleBar.border" = invisible;

    "commandCenter.background" = palette.dark-gray;
    "commandCenter.foreground" = palette.white;
    "commandCenter.border" = invisible;
    "commandCenter.activeBackground" = palette.dim-gray;
    "commandCenter.activeForeground" = palette.white;

    "menu.background" = palette.black;
    "menu.foreground" = palette.white;
    "menu.selectionBackground" = palette.dim-gray;
    "menu.selectionForeground" = palette.white;
    "menu.separatorBackground" = palette.dark-gray;
    "menu.border" = palette.dark-gray;

    "menubar.background" = palette.black;
    "menubar.foreground" = palette.white;
    "menubar.selectionBackground" = palette.dim-gray;
    "menubar.selectionForeground" = palette.white;
    "menubar.selectionBorder" = invisible;

    "breadcrumb.background" = palette.black;
    "breadcrumb.foreground" = palette.light-gray;
    "breadcrumb.focusForeground" = palette.white;
    "breadcrumb.activeSelectionForeground" = palette.white;

    "notifications.background" = palette.black;
    "notifications.foreground" = palette.white;
    "notifications.border" = palette.dark-gray;

    "notificationLink.foreground" = palette.blue;
    "notificationsInfoIcon.foreground" = palette.blue;
    "notificationsErrorIcon.foreground" = palette.red;
    "notificationsWarningIcon.foreground" = palette.orange;

    "statusBar.background" = palette.dark-gray;
    "statusBar.foreground" = palette.white;
    "statusBar.border" = palette.dark-gray;
    "statusBar.noFolderBackground" = palette.dark-gray;
    "statusBar.debuggingBackground" = palette.blue;
    "statusBar.debuggingForeground" = palette.black;
    "statusBarItem.remoteBackground" = palette.blue;
    "statusBarItem.remoteForeground" = palette.black;
    "statusBarItem.hoverBackground" = palette.dim-gray;
  };
}
