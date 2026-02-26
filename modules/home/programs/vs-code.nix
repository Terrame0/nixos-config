{
  pkgs,
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;

    profiles.default = let
      marketplace-extensions = pkgs.nix4vscode.forVscode [
        "twxs.cmake"
        "ms-python.python"
        "jnoortheen.nix-ide"
        "charliermarsh.ruff"
        "mads-hartmann.bash-ide-vscode"
        "llvm-vs-code-extensions.vscode-clangd"
      ];
    in {
      # ============================================================
      # -- extensions
      # ============================================================

      extensions = marketplace-extensions;

      # ============================================================
      # -- user settings
      # ============================================================

      userSettings = let
        invisible = "#ffffff00";
      in {
        # ============================================================
        # -- disabling linting for some languages
        # ============================================================

        "css.validate" = false;

        # ============================================================
        # -- fixing inconsistent integrated terminal environment
        # ============================================================

        "terminal.integrated.inheritEnv" = false;
        "C_Cpp.default.includePath" = [];

        # ============================================================
        # -- clangd settings
        # ============================================================

        "clangd.path" = "clangd";
        "clangd.arguments" = [
          "--background-index"
          "--clang-tidy"
          "--header-insertion=iwyu"
          "--completion-style=detailed"
        ];

        # ============================================================
        # -- nix language server integration
        # ============================================================

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.hiddenLanguageServerErrors" = ["textDocument/definition"];
        "nix.serverSettings" = {
          "nixd" = let
            flake = "(builtins.getFlake (builtins.toString ./.))";
          in {
            "formatting" = {
              "command" = ["alejandra"];
            };
            "nixpkgs" = {
              "expr" = "import ''\${${flake}.inputs.nixpkgs}'' { system = builtins.currentSystem; }";
            };
            "options" = {
              "nixos" = {
                "expr" = "(let pkgs = import ''\${${flake}.inputs.nixpkgs}'' { system = builtins.currentSystem; }; in (pkgs.lib.evalModules { modules =  (import ''\${${flake}.inputs.nixpkgs}/nixos/modules/module-list.nix'') ++ [ ({...}: { nixpkgs.hostPlatform = builtins.currentSystem;} ) ] ; })).options";
              };
              "home_manager" = {
                "expr" = "(let pkgs = import ''\${${flake}.inputs.nixpkgs}'' { system = builtins.currentSystem; }; lib = import ''\${${flake}.inputs.home-manager}/modules/lib/stdlib-extended.nix'' pkgs.lib; in (lib.evalModules { modules =  (import ''\${${flake}.inputs.home-manager}/modules/modules.nix'') { inherit lib pkgs; check = false; }; })).options";
              };
            };
          };
        };

        # ============================================================
        # -- misc behavior
        # ============================================================

        "editor.smoothScrolling" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.untrustedFiles" = "open";
        "telemetry.telemetryLevel" = "off";
        "chat.disableAIFeatures" = true;
        "terminal.external.linuxExec" = "alacritty";

        # ============================================================
        # -- updates and recommendations
        # ============================================================

        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "extensions.ignoreRecommendations" = true;

        # ============================================================
        # -- startup and welcome
        # ============================================================

        "workbench.startupEditor" = "none";
        "workbench.welcome.enabled" = false;
        "workbench.tips.enabled" = false;
        "workbench.enableExperiments" = false;

        # ============================================================
        # -- fonts and cursor
        # ============================================================

        "editor.fontFamily" = "JetBrainsMono NFP";
        "editor.fontLigatures" = true;
        "editor.cursorStyle" = "line";
        "editor.cursorBlinking" = "solid";
        "editor.cursorSmoothCaretAnimation" = "on";

        # ============================================================
        # -- layout
        # ============================================================

        "editor.minimap.enabled" = false;
        "workbench.tree.indent" = 20;
        "workbench.colorTheme" = "Default Dark Modern";
        "workbench.iconTheme" = "vs-seti";

        # ============================================================
        # -- window and titlebar
        # ============================================================

        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "classic";

        # ============================================================
        # -- ui theming
        # ============================================================

        "workbench.colorCustomizations" = {
          # ----------------------------------------------------------
          # -- editor core
          # ----------------------------------------------------------

          "editor.background" = config.palette.background;
          "editor.foreground" = config.palette.foreground;

          "editor.selectionBackground" = config.palette.selection;
          "editor.selectionForeground" = config.palette.foreground;
          "editor.selectionHighlightBackground" = config.palette.selection;
          "editor.selectionHighlightBorder" = invisible;

          "editor.lineHighlightBackground" = config.palette.line;

          "editorCursor.foreground" = config.palette.foreground;
          "editorLineNumber.foreground" = config.palette.window;
          "editorLineNumber.activeForeground" = config.palette.foreground;

          "focusBorder" = invisible;
          "contrastBorder" = invisible;

          # ----------------------------------------------------------
          # -- activity bar
          # ----------------------------------------------------------

          "activityBar.background" = config.palette.background;
          "activityBar.foreground" = config.palette.foreground;
          "activityBar.inactiveForeground" = config.palette.comment;
          "activityBar.border" = invisible;
          "activityBar.activeBorder" = invisible;
          "activityBar.activeFocusBorder" = invisible;

          # ----------------------------------------------------------
          # -- sidebar and explorer
          # ----------------------------------------------------------

          "sideBar.background" = config.palette.background;
          "sideBar.foreground" = config.palette.foreground;
          "sideBar.border" = config.palette.line;

          # ----------------------------------------------------------
          # -- tabs
          # ----------------------------------------------------------

          "tab.activeBackground" = config.palette.line;
          "tab.activeForeground" = config.palette.foreground;

          "tab.inactiveBackground" = config.palette.background;
          "tab.inactiveForeground" = config.palette.comment;

          "tab.inactiveBorder" = invisible;
          "tab.unfocusedInactiveBorder" = invisible;
          "tab.activeBorderTop" = invisible;
          "tab.unfocusedActiveBorderTop" = invisible;
          "tab.selectedBorderTop" = invisible;
          "tab.border" = invisible;
          "tab.activeBorder" = invisible;
          "tab.unfocusedActiveBorder" = invisible;
          "tab.activeModifiedBorder" = invisible;

          "tab.activeModifiedForeground" = config.palette.background;
          "tab.inactiveModifiedForeground" = config.palette.comment;

          "problems.decorations.enabled" = false;
          "scm.diffDecorations" = "none";

          # ----------------------------------------------------------
          # -- title bar and command center
          # ----------------------------------------------------------

          "titleBar.activeBackground" = config.palette.background;
          "titleBar.activeForeground" = config.palette.foreground;
          "titleBar.inactiveBackground" = config.palette.background;
          "titleBar.inactiveForeground" = config.palette.comment;
          "titleBar.border" = invisible;

          "commandCenter.background" = config.palette.line;
          "commandCenter.foreground" = config.palette.foreground;
          "commandCenter.border" = invisible;
          "commandCenter.activeBackground" = config.palette.selection;
          "commandCenter.activeForeground" = config.palette.foreground;

          # ----------------------------------------------------------
          # -- panels and inputs
          # ----------------------------------------------------------

          "panel.background" = config.palette.background;
          "panel.border" = config.palette.line;
          "panelTitle.activeForeground" = config.palette.foreground;
          "panelTitle.inactiveForeground" = config.palette.comment;

          "input.background" = config.palette.line;
          "input.foreground" = config.palette.foreground;
          "input.border" = config.palette.line;

          "dropdown.background" = config.palette.line;
          "dropdown.foreground" = config.palette.foreground;
          "dropdown.border" = config.palette.line;

          # ----------------------------------------------------------
          # -- scrollbar
          # ----------------------------------------------------------

          "scrollbar.shadow" = invisible;
          "scrollbarSlider.background" = "${config.palette.window}99";
          "scrollbarSlider.hoverBackground" = "${config.palette.comment}cc";
          "scrollbarSlider.activeBackground" = config.palette.foreground;

          # ----------------------------------------------------------
          # -- git decorations
          # ----------------------------------------------------------

          "gitDecoration.modifiedResourceForeground" = config.palette.yellow;
          "gitDecoration.addedResourceForeground" = config.palette.green;
          "gitDecoration.deletedResourceForeground" = config.palette.red;
          "gitDecoration.untrackedResourceForeground" = config.palette.aqua;
          "gitDecoration.ignoredResourceForeground" = config.palette.comment;
          "gitDecoration.renamedResourceForeground" = config.palette.aqua;

          # ----------------------------------------------------------
          # -- gutter and overview ruler
          # ----------------------------------------------------------

          "editorGutter.addedBackground" = config.palette.green;
          "editorGutter.modifiedBackground" = config.palette.yellow;
          "editorGutter.deletedBackground" = config.palette.red;

          "editorOverviewRuler.addedForeground" = "${config.palette.green}99";
          "editorOverviewRuler.modifiedForeground" = "${config.palette.yellow}99";
          "editorOverviewRuler.deletedForeground" = "${config.palette.red}99";
          "editorOverviewRuler.commonContentForeground" = "${config.palette.window}99";
          "editorOverviewRuler.warningForeground" = config.palette.orange;

          # ----------------------------------------------------------
          # -- diagnostics
          # ----------------------------------------------------------

          "editorError.foreground" = config.palette.red;
          "editorWarning.foreground" = config.palette.orange;
          "editorInfo.foreground" = config.palette.foreground;
          "editorHint.foreground" = config.palette.comment;

          "editor.errorDecoration" = "underline";
          "editor.warningDecoration" = "underline";
          "editor.infoDecoration" = "underline";

          # ----------------------------------------------------------
          # -- search and find
          # ----------------------------------------------------------

          "editor.findMatchForeground" = config.palette.background;
          "editor.findMatchBackground" = config.palette.green;
          "editor.findMatchBorder" = invisible;

          "editor.findMatchHighlightForeground" = config.palette.background;
          "editor.findMatchHighlightBackground" = config.palette.foreground;
          "editor.findMatchHighlightBorder" = invisible;

          # ----------------------------------------------------------
          # -- debug
          # ----------------------------------------------------------

          "debugToolBar.background" = config.palette.line;
          "debugToolBar.border" = invisible;

          "textLink.foreground" = config.palette.blue;
          "textLink.activeForeground" = config.palette.blue;
          "textLink.border" = invisible;

          "debugConsole.infoForeground" = config.palette.blue;
          "debugConsole.warningForeground" = config.palette.yellow;
          "debugConsole.errorForeground" = config.palette.red;
          "debugConsoleLink.foreground" = config.palette.blue;

          # ----------------------------------------------------------
          # -- terminal
          # ----------------------------------------------------------

          "terminal.background" = config.palette.background;
          "terminal.foreground" = config.palette.foreground;
          "terminal.border" = config.palette.line;
          "terminal.selectionBackground" = config.palette.selection;

          "terminal.tab.activeBackground" = config.palette.line;
          "terminal.tab.activeForeground" = config.palette.foreground;
          "terminal.tab.inactiveBackground" = config.palette.background;
          "terminal.tab.inactiveForeground" = config.palette.comment;
          "terminal.tab.activeBorder" = config.palette.line;
          "terminal.tab.activeBorderTop" = config.palette.line;
          "terminal.tab.activeIconForeground" = invisible;
          "terminal.tab.inactiveIconForeground" = invisible;

          "terminal.ansiBlack" = config.palette.background;
          "terminal.ansiRed" = config.palette.red;
          "terminal.ansiGreen" = config.palette.green;
          "terminal.ansiYellow" = config.palette.yellow;
          "terminal.ansiBlue" = config.palette.blue;
          "terminal.ansiMagenta" = config.palette.purple;
          "terminal.ansiCyan" = config.palette.aqua;
          "terminal.ansiWhite" = config.palette.foreground;

          "terminal.ansiBrightBlack" = config.palette.window;
          "terminal.ansiBrightRed" = config.palette.red;
          "terminal.ansiBrightGreen" = config.palette.green;
          "terminal.ansiBrightYellow" = config.palette.yellow;
          "terminal.ansiBrightBlue" = config.palette.blue;
          "terminal.ansiBrightMagenta" = config.palette.purple;
          "terminal.ansiBrightCyan" = config.palette.aqua;
          "terminal.ansiBrightWhite" = config.palette.foreground;

          # ----------------------------------------------------------
          # -- hover and word highlight
          # ----------------------------------------------------------

          "editor.wordHighlightBackground" = "${config.palette.blue}2E";
          "editor.wordHighlightStrongBackground" = "${config.palette.blue}2E";

          "editorHoverWidget.background" = config.palette.line;
          "editorHoverWidget.foreground" = config.palette.foreground;
          "editorHoverWidget.border" = invisible;

          # ----------------------------------------------------------
          # -- suggest widget
          # ----------------------------------------------------------

          "suggestWidget.background" = config.palette.background;
          "suggestWidget.foreground" = config.palette.foreground;
          "suggestWidget.border" = config.palette.line;

          "suggestWidget.selectedBackground" = config.palette.selection;
          "suggestWidget.selectedForeground" = config.palette.foreground;

          "suggestWidget.highlightForeground" = config.palette.green;
          "suggestWidget.detailForeground" = config.palette.foreground;
          "suggestWidget.documentationFontSize" = 12;

          "suggestWidgetScrollbarSlider.background" = config.palette.window;
          "suggestWidgetScrollbarSlider.hoverBackground" = config.palette.comment;
          "suggestWidgetScrollbarSlider.activeBackground" = config.palette.foreground;

          # ----------------------------------------------------------
          # -- buttons and badges
          # ----------------------------------------------------------

          "button.background" = config.palette.line;
          "button.foreground" = config.palette.foreground;
          "button.hoverBackground" = config.palette.selection;
          "button.border" = invisible;

          "button.secondaryBackground" = invisible;
          "button.secondaryForeground" = config.palette.foreground;

          "badge.background" = config.palette.line;
          "badge.foreground" = config.palette.foreground;

          "extensionButton.background" = config.palette.line;
          "extensionButton.foreground" = config.palette.foreground;
          "extensionButton.hoverBackground" = config.palette.selection;
          "extensionButton.prominentBackground" = config.palette.line;
          "extensionButton.prominentForeground" = config.palette.foreground;
          "extensionButton.separator" = config.palette.window;

          # ----------------------------------------------------------
          # -- menus
          # ----------------------------------------------------------

          "menu.background" = config.palette.background;
          "menu.foreground" = config.palette.foreground;
          "menu.selectionBackground" = config.palette.selection;
          "menu.selectionForeground" = config.palette.foreground;
          "menu.separatorBackground" = config.palette.line;
          "menu.border" = config.palette.line;

          "menubar.background" = config.palette.background;
          "menubar.foreground" = config.palette.foreground;
          "menubar.selectionBackground" = config.palette.selection;
          "menubar.selectionForeground" = config.palette.foreground;
          "menubar.selectionBorder" = invisible;

          # ----------------------------------------------------------
          # -- notifications
          # ----------------------------------------------------------

          "notifications.background" = config.palette.background;
          "notifications.foreground" = config.palette.foreground;
          "notifications.border" = config.palette.line;

          "notificationLink.foreground" = config.palette.blue;
          "notificationsInfoIcon.foreground" = config.palette.blue;
          "notificationsErrorIcon.foreground" = config.palette.red;
          "notificationsWarningIcon.foreground" = config.palette.orange;

          # ----------------------------------------------------------
          # -- breadcrumbs
          # ----------------------------------------------------------

          "breadcrumb.background" = config.palette.background;
          "breadcrumb.foreground" = config.palette.comment;
          "breadcrumb.focusForeground" = config.palette.foreground;
          "breadcrumb.activeSelectionForeground" = config.palette.foreground;

          # ----------------------------------------------------------
          # -- diff editor
          # ----------------------------------------------------------

          "diffEditor.insertedTextBackground" = "${config.palette.green}33";
          "diffEditor.removedTextBackground" = "${config.palette.red}33";

          # ----------------------------------------------------------
          # -- brackets and guides
          # ----------------------------------------------------------

          "editorBracketMatch.background" = invisible;
          "editorBracketMatch.border" = invisible;

          "editorBracketHighlight.foreground1" = config.palette.comment;
          "editorBracketHighlight.foreground2" = config.palette.comment;
          "editorBracketHighlight.foreground3" = config.palette.comment;
          "editorBracketHighlight.foreground4" = config.palette.comment;
          "editorBracketHighlight.foreground5" = config.palette.comment;
          "editorBracketHighlight.foreground6" = config.palette.comment;

          "editorBracketPairGuide.activeBackground1" = invisible;
          "editorBracketPairGuide.activeBackground2" = invisible;
          "editorBracketPairGuide.activeBackground3" = invisible;
          "editorBracketPairGuide.activeBackground4" = invisible;
          "editorBracketPairGuide.activeBackground5" = invisible;
          "editorBracketPairGuide.activeBackground6" = invisible;

          "editorBracketPairGuide.background1" = invisible;
          "editorBracketPairGuide.background2" = invisible;
          "editorBracketPairGuide.background3" = invisible;
          "editorBracketPairGuide.background4" = invisible;
          "editorBracketPairGuide.background5" = invisible;
          "editorBracketPairGuide.background6" = invisible;

          "editor.guides.bracketPairs" = config.palette.selection;
          "editor.guides.bracketPairsActive" = config.palette.selection;
          # ----------------------------------------------------------
          # -- list renderer
          # ----------------------------------------------------------

          "list.activeSelectionBackground" = config.palette.selection;
          "list.activeSelectionForeground" = config.palette.foreground;
          "list.activeSelectionIconForeground" = config.palette.green;

          "list.inactiveSelectionBackground" = config.palette.line;
          "list.inactiveSelectionForeground" = config.palette.foreground;

          "list.hoverBackground" = config.palette.line;

          "list.foreground" = config.palette.foreground;
          "list.focusForeground" = config.palette.foreground;

          "list.focusOutline" = invisible;

          "tree.indentGuidesStroke" = config.palette.foreground;

          # ----------------------------------------------------------
          # -- suggestion widget internals
          # ----------------------------------------------------------

          "list.highlightForeground" = config.palette.foreground;
          "list.focusHighlightForeground" = config.palette.green;

          "editorSuggestWidget.background" = config.palette.background;
          "editorSuggestWidget.foreground" = config.palette.foreground;
          "editorSuggestWidget.border" = config.palette.line;

          "editorSuggestWidget.highlightForeground" = config.palette.foreground;

          "editorSuggestWidget.selectedBackground" = config.palette.line;
          "editorSuggestWidget.selectedForeground" = config.palette.green;

          "symbolIcon.textForeground" = config.palette.foreground;
        };

        # ============================================================
        # -- editor behavior
        # ============================================================

        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = true;

        # ============================================================
        # -- syntax theming
        # ============================================================

        "editor.semanticHighlighting.enabled" = false;

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            # -- punctuation
            {
              scope = "punctuation";
              settings.foreground = config.palette.comment;
            }

            # -- comments
            {
              scope = "comment";
              settings.foreground = config.palette.comment;
            }

            # -- variables
            {
              scope = [
                "variable.other.object"
                "variable"
                "variable.parameter"
                "variable.other.readwrite"
              ];
              settings.foreground = config.palette.foreground;
            }

            # -- attributes and properties
            {
              scope = [
                "variable.other.object.property"
                "variable.other.property"
                "entity.other.attribute-name"
                "entity.name.tag"
              ];
              settings.foreground = config.palette.foreground;
            }

            # -- keywords
            {
              scope = [
                "keyword"
                "keyword.control"
                "keyword.other"
                "keyword.other.operator"
                "keyword.other.using"
              ];
              settings.foreground = config.palette.purple;
            }

            # -- operators
            {
              scope = "keyword.operator";
              settings.foreground = config.palette.comment;
            }

            # -- namespaces
            {
              scope = [
                "entity.name.scope-resolution"
                "entity.name.namespace"
              ];
              settings.foreground = config.palette.aqua;
            }

            # -- types
            {
              scope = [
                "entity.name.type"
                "storage.type"
                "support.type"
              ];
              settings.foreground = config.palette.blue;
            }

            # -- storage modifiers
            {
              scope = [
                "storage.modifier"
              ];
              settings.foreground = config.palette.blue;
            }

            # -- functions
            {
              scope = [
                "meta.function"
                "entity.name.function"
                "support.function"
              ];
              settings.foreground = config.palette.orange;
            }

            # -- structures
            {
              scope = [
                "storage.type.struct"
                "storage.type.class"
              ];
              settings.foreground = config.palette.orange;
            }

            # -- templates
            {
              scope = [
                "storage.type.template"
              ];
              settings.foreground = config.palette.red;
            }

            # -- strings
            {
              scope = [
                "string"
                "string.quoted"
                "string.template"
                "string.interpolated"
              ];
              settings.foreground = config.palette.orange;
            }

            # -- numeric values
            {
              scope = [
                "constant.numeric.float.suffix"
                "constant.numeric"
                "keyword.other.unit.suffix.floating-point"
              ];
              settings.foreground = config.palette.purple;
            }

            # -- constants
            {
              scope = [
                "constant.language"
              ];
              settings.foreground = config.palette.purple;
            }

            # -- fallback
            {
              scope = [
                "meta"
                "source.cpp"
              ];
              settings.foreground = config.palette.foreground;
            }
          ];
        };
      };
    };
  };
}
