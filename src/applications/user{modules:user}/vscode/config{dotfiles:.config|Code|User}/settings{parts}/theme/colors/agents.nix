{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "agentStatusIndicator.background" = palette.black;

    "agents.background" = palette.black;

    "agentsBadge.background" = palette.blue;
    "agentsBadge.foreground" = palette.black;

    "agentsChatInput.background" = palette.dark-gray;
    "agentsChatInput.border" = palette.dark-gray;
    "agentsChatInput.focusBorder" = palette.blue;
    "agentsChatInput.foreground" = palette.white;
    "agentsChatInput.placeholderForeground" = palette.light-gray;

    "agentsGradient.tintColor" = palette.blue;

    "agentsNewSessionButton.background" = invisible;
    "agentsNewSessionButton.border" = palette.dark-gray;
    "agentsNewSessionButton.foreground" = palette.white;
    "agentsNewSessionButton.hoverBackground" = "${palette.gray}10";

    "agentsPanel.background" = palette.black;
    "agentsPanel.border" = palette.dark-gray;
    "agentsPanel.foreground" = palette.white;

    "agentsUnreadBadge.background" = palette.blue;
    "agentsUnreadBadge.foreground" = palette.black;

    "chat.editedFileForeground" = palette.orange;
    "chat.inputWorkingBorderColor1" = palette.blue;
    "chat.inputWorkingBorderColor2" = palette.blue;
    "chat.inputWorkingBorderColor3" = palette.blue;
    "chat.requestBubbleBackground" = palette.black;
    "chat.requestBubbleHoverBackground" = palette.black;
    "chat.slashCommandBackground" = "${palette.dim-gray}7a";
    "chat.slashCommandForeground" = palette.blue;
    "chat.thinkingShimmer" = palette.light-gray;

    "inlineChat.border" = invisible;
  };
}
