{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "scrollbar.shadow" = invisible;
    "scrollbarSlider.background" = "${palette.gray}99";
    "scrollbarSlider.hoverBackground" = "${palette.light-gray}cc";
    "scrollbarSlider.activeBackground" = palette.white;

    "editorHoverWidget.background" = palette.dark-gray;
    "editorHoverWidget.foreground" = palette.white;
    "editorHoverWidget.border" = invisible;

    "suggestWidget.background" = palette.black;
    "suggestWidget.foreground" = palette.white;
    "suggestWidget.border" = palette.dark-gray;
    "suggestWidget.selectedBackground" = palette.dim-gray;
    "suggestWidget.selectedForeground" = palette.white;
    "suggestWidget.highlightForeground" = palette.green;
    "suggestWidget.detailForeground" = palette.white;
    "suggestWidget.documentationFontSize" = 12;

    "suggestWidgetScrollbarSlider.background" = palette.gray;
    "suggestWidgetScrollbarSlider.hoverBackground" = palette.light-gray;
    "suggestWidgetScrollbarSlider.activeBackground" = palette.white;

    "editorSuggestWidget.background" = palette.black;
    "editorSuggestWidget.foreground" = palette.white;
    "editorSuggestWidget.border" = palette.dark-gray;
    "editorSuggestWidget.highlightForeground" = palette.white;
    "editorSuggestWidget.selectedBackground" = palette.dark-gray;
    "editorSuggestWidget.selectedForeground" = palette.green;

    "button.background" = palette.dark-gray;
    "button.foreground" = palette.white;
    "button.hoverBackground" = palette.dim-gray;
    "button.border" = invisible;
    "button.secondaryBackground" = invisible;
    "button.secondaryForeground" = palette.white;

    "badge.background" = palette.dark-gray;
    "badge.foreground" = palette.white;

    "extensionButton.background" = palette.dark-gray;
    "extensionButton.foreground" = palette.white;
    "extensionButton.hoverBackground" = palette.dim-gray;
    "extensionButton.prominentBackground" = palette.dark-gray;
    "extensionButton.prominentForeground" = palette.white;
    "extensionButton.separator" = palette.gray;

    "debugToolBar.background" = palette.dark-gray;
    "debugToolBar.border" = invisible;

    "textLink.foreground" = palette.blue;
    "textLink.activeForeground" = palette.blue;
    "textLink.border" = invisible;

    "debugConsole.infoForeground" = palette.blue;
    "debugConsole.warningForeground" = palette.yellow;
    "debugConsole.errorForeground" = palette.red;
    "debugConsoleLink.foreground" = palette.blue;

    "symbolIcon.textForeground" = palette.white;

    "editorWidget.background" = palette.dark-gray;
    "editorWidget.foreground" = palette.white;
    "editorWidget.border" = palette.dim-gray;
    "widget.border" = palette.dim-gray;

    "actionBar.toggledBackground" = palette.dim-gray;

    "quickInput.background" = palette.dark-gray;
    "quickInput.foreground" = palette.white;
    "quickInputList.focusBackground" = palette.dim-gray;
    "quickInputList.focusForeground" = palette.white;
    "quickInputList.focusHighlightForeground" = palette.green;

    "activityErrorBadge.background" = palette.red;
    "activityErrorBadge.foreground" = palette.black;
    "activityWarningBadge.background" = palette.yellow;
    "activityWarningBadge.foreground" = palette.white;
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
    "button.secondaryHoverBackground" = palette.dark-gray;
    "charts.blue" = palette.blue;
    "charts.foreground" = palette.white;
    "charts.green" = palette.green;
    "charts.lines" = "${palette.white}66";
    "charts.orange" = palette.orange;
    "charts.purple" = palette.purple;
    "charts.red" = palette.red;
    "charts.yellow" = palette.yellow;
    "chat.editedFileForeground" = palette.orange;
    "chat.inputWorkingBorderColor1" = palette.blue;
    "chat.inputWorkingBorderColor2" = palette.blue;
    "chat.inputWorkingBorderColor3" = palette.blue;
    "chat.requestBubbleBackground" = palette.black;
    "chat.requestBubbleHoverBackground" = palette.black;
    "chat.slashCommandBackground" = "${palette.dim-gray}7a";
    "chat.slashCommandForeground" = palette.blue;
    "chat.thinkingShimmer" = palette.light-gray;
    "checkbox.background" = palette.dark-gray;
    "checkbox.border" = palette.dark-gray;
    "checkbox.foreground" = palette.light-gray;
    "extensionButton.prominentHoverBackground" = palette.blue;
    "inlineChat.border" = invisible;
    "notebook.cellBorderColor" = palette.dark-gray;
    "notebook.selectedCellBackground" = "${palette.dim-gray}50";
    "peekView.border" = palette.blue;
    "peekViewEditor.background" = palette.black;
    "peekViewEditor.matchHighlightBackground" = "${palette.blue}33";
    "peekViewResult.background" = palette.black;
    "peekViewResult.fileForeground" = palette.white;
    "peekViewResult.lineForeground" = palette.light-gray;
    "peekViewResult.matchHighlightBackground" = "${palette.blue}33";
    "peekViewResult.selectionBackground" = "${palette.blue}26";
    "peekViewResult.selectionForeground" = palette.white;
    "peekViewTitle.background" = palette.black;
    "peekViewTitleDescription.foreground" = palette.light-gray;
    "peekViewTitleLabel.foreground" = palette.white;
    "pickerGroup.border" = palette.dark-gray;
    "pickerGroup.foreground" = palette.white;
    "ports.iconRunningProcessForeground" = palette.green;
    "progressBar.background" = palette.blue;
    "quickInputList.focusIconForeground" = palette.black;
    "quickInputTitle.background" = palette.dark-gray;
    "searchEditor.textInputBorder" = palette.dark-gray;
    "settings.dropdownBackground" = palette.dark-gray;
    "settings.dropdownBorder" = palette.dark-gray;
    "settings.headerForeground" = palette.white;
    "settings.modifiedItemIndicator" = "${palette.orange}66";
    "settings.numberInputBorder" = palette.dark-gray;
    "settings.textInputBorder" = palette.dark-gray;
    "textBlockQuote.background" = palette.black;
    "textBlockQuote.border" = palette.dark-gray;
    "textCodeBlock.background" = palette.black;
    "textPreformat.background" = palette.black;
    "textPreformat.foreground" = palette.light-gray;
    "textSeparator.foreground" = palette.light-gray;
    "toolbar.hoverBackground" = "${palette.gray}10";
    "welcomePage.tileBackground" = palette.black;
    "widget.shadow" = invisible;
  };
}
