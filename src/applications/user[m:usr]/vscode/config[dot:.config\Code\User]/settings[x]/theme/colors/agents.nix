{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "agentStatusIndicator.background" = palette.neutral-1000;

    "agents.background" = palette.neutral-1000;

    "agentsBadge.background" = palette.blue;
    "agentsBadge.foreground" = palette.neutral-1000;

    "agentsChatInput.background" = palette.neutral-800;
    "agentsChatInput.border" = palette.neutral-800;
    "agentsChatInput.focusBorder" = palette.blue;
    "agentsChatInput.foreground" = palette.neutral-0;
    "agentsChatInput.placeholderForeground" = palette.neutral-200;

    "agentsGradient.tintColor" = palette.blue;

    "agentsNewSessionButton.background" = invisible;
    "agentsNewSessionButton.border" = palette.neutral-800;
    "agentsNewSessionButton.foreground" = palette.neutral-0;
    "agentsNewSessionButton.hoverBackground" = "${palette.neutral-400}10";

    "agentsPanel.background" = palette.neutral-1000;
    "agentsPanel.border" = palette.neutral-800;
    "agentsPanel.foreground" = palette.neutral-0;

    "agentsUnreadBadge.background" = palette.blue;
    "agentsUnreadBadge.foreground" = palette.neutral-1000;

    "chat.editedFileForeground" = palette.orange;
    "chat.inputWorkingBorderColor1" = palette.blue;
    "chat.inputWorkingBorderColor2" = palette.blue;
    "chat.inputWorkingBorderColor3" = palette.blue;
    "chat.requestBubbleBackground" = palette.neutral-1000;
    "chat.requestBubbleHoverBackground" = palette.neutral-1000;
    "chat.slashCommandBackground" = "${palette.neutral-600}7a";
    "chat.slashCommandForeground" = palette.blue;
    "chat.thinkingShimmer" = palette.neutral-200;

    "inlineChat.border" = invisible;
  };
}
