{
  lib,
  pkgs,
  ...
}: {
  # -- ui
  "editor.smoothScrolling" = true;
  "workbench.startupEditor" = "none";
  "workbench.welcome.enabled" = false;
  "workbench.tips.enabled" = false;
  "workbench.enableExperiments" = false;

  # -- behavior
  "explorer.confirmDelete" = false;
  "explorer.confirmDragAndDrop" = false;
  "keyboard.dispatch" = "keyCode";

  # -- system
  "terminal.external.linuxExec" = "alacritty";
  "terminal.integrated.profiles.linux" = {
    Nushell.path = lib.getExe pkgs.nushell;
  };
  "terminal.integrated.defaultProfile.linux" = "Nushell";
  "terminal.integrated.automationProfile.linux" = {
    path = lib.getExe pkgs.zsh;
  };
  "security.workspace.trust.untrustedFiles" = "open";

  # -- updates
  "update.mode" = "none";
  "update.showReleaseNotes" = false;
  "extensions.autoUpdate" = false;
  "extensions.autoCheckUpdates" = false;

  # -- misc
  "telemetry.telemetryLevel" = "off";
  "chat.disableAIFeatures" = true;
  "extensions.ignoreRecommendations" = true;
}
