{
  pkgs,
  lib,
  ...
}: {
  # -- make the extension shut up
  "qt-core.doNotAskForDefaultQtInstallationRoot" = true;
  "qt-core.doNotAskForVCPKG" = true;
  "qt-core.showWelcomePageOnActivation" = false;
  "qt-qml.doNotAskForQmllsDownload" = true;

  # -- the extension tries to append this to settings.json so we do it beforehands
  "workbench.editorAssociations" = {
    "{git,gitlens,chat-editing-snapshot-text-model,copilot,git-graph,git-graph-3}:/**/*.qrc" = "default";
    "*.qrc" = "qt-core.qrcEditor";
  };

  "qt-qml.qmlls.enabled" = true;
  "qt-qml.qmlls.traceLsp" = "messages";
  "qt-qml.qmlls.customExePath" = lib.getExe' pkgs.qt6.qtdeclarative "qmlls";
}
