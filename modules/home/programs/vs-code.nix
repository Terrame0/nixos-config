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
        "clangd.trace" = "/tmp/clangd-log.txt";
        "clangd.arguments" = [
          "--background-index"
          "--clang-tidy"
          "--header-insertion=iwyu"
          "--completion-style=detailed"
          "--log=verbose"
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

        "editor.fontFamily" = config.style.font.propo;
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

          "editor.background" = config.style.palette.black;
          "editor.foreground" = config.style.palette.white;

          "editor.selectionBackground" = config.style.palette.dim-gray;
          "editor.selectionForeground" = config.style.palette.white;
          "editor.selectionHighlightBackground" = config.style.palette.dim-gray;
          "editor.selectionHighlightBorder" = invisible;

          "editor.lineHighlightBackground" = config.style.palette.dark-gray;

          "editorCursor.foreground" = config.style.palette.white;
          "editorLineNumber.foreground" = config.style.palette.gray;
          "editorLineNumber.activeForeground" = config.style.palette.white;

          "focusBorder" = invisible;
          "contrastBorder" = invisible;

          # ----------------------------------------------------------
          # -- activity bar
          # ----------------------------------------------------------

          "activityBar.background" = config.style.palette.black;
          "activityBar.foreground" = config.style.palette.white;
          "activityBar.inactiveForeground" = config.style.palette.light-gray;
          "activityBar.border" = invisible;
          "activityBar.activeBorder" = invisible;
          "activityBar.activeFocusBorder" = invisible;

          # ----------------------------------------------------------
          # -- sidebar and explorer
          # ----------------------------------------------------------

          "sideBar.background" = config.style.palette.black;
          "sideBar.foreground" = config.style.palette.white;
          "sideBar.border" = config.style.palette.dark-gray;

          # ----------------------------------------------------------
          # -- tabs
          # ----------------------------------------------------------

          "tab.activeBackground" = config.style.palette.dark-gray;
          "tab.activeForeground" = config.style.palette.white;

          "tab.inactiveBackground" = config.style.palette.black;
          "tab.inactiveForeground" = config.style.palette.light-gray;

          "tab.inactiveBorder" = invisible;
          "tab.unfocusedInactiveBorder" = invisible;
          "tab.activeBorderTop" = invisible;
          "tab.unfocusedActiveBorderTop" = invisible;
          "tab.selectedBorderTop" = invisible;
          "tab.border" = invisible;
          "tab.activeBorder" = invisible;
          "tab.unfocusedActiveBorder" = invisible;
          "tab.activeModifiedBorder" = invisible;

          "tab.activeModifiedForeground" = config.style.palette.black;
          "tab.inactiveModifiedForeground" = config.style.palette.light-gray;

          "problems.decorations.enabled" = false;
          "scm.diffDecorations" = "none";

          # ----------------------------------------------------------
          # -- title bar and command center
          # ----------------------------------------------------------

          "titleBar.activeBackground" = config.style.palette.black;
          "titleBar.activeForeground" = config.style.palette.white;
          "titleBar.inactiveBackground" = config.style.palette.black;
          "titleBar.inactiveForeground" = config.style.palette.light-gray;
          "titleBar.border" = invisible;

          "commandCenter.background" = config.style.palette.dark-gray;
          "commandCenter.foreground" = config.style.palette.white;
          "commandCenter.border" = invisible;
          "commandCenter.activeBackground" = config.style.palette.dim-gray;
          "commandCenter.activeForeground" = config.style.palette.white;

          # ----------------------------------------------------------
          # -- panels and inputs
          # ----------------------------------------------------------

          "panel.background" = config.style.palette.black;
          "panel.border" = config.style.palette.dark-gray;
          "panelTitle.activeForeground" = config.style.palette.white;
          "panelTitle.inactiveForeground" = config.style.palette.light-gray;

          "input.background" = config.style.palette.dark-gray;
          "input.foreground" = config.style.palette.white;
          "input.border" = config.style.palette.dark-gray;

          "dropdown.background" = config.style.palette.dark-gray;
          "dropdown.foreground" = config.style.palette.white;
          "dropdown.border" = config.style.palette.dark-gray;

          # ----------------------------------------------------------
          # -- scrollbar
          # ----------------------------------------------------------

          "scrollbar.shadow" = invisible;
          "scrollbarSlider.background" = "${config.style.palette.gray}99";
          "scrollbarSlider.hoverBackground" = "${config.style.palette.light-gray}cc";
          "scrollbarSlider.activeBackground" = config.style.palette.white;

          # ----------------------------------------------------------
          # -- git decorations
          # ----------------------------------------------------------

          "gitDecoration.modifiedResourceForeground" = config.style.palette.yellow;
          "gitDecoration.addedResourceForeground" = config.style.palette.green;
          "gitDecoration.deletedResourceForeground" = config.style.palette.red;
          "gitDecoration.untrackedResourceForeground" = config.style.palette.aqua;
          "gitDecoration.ignoredResourceForeground" = config.style.palette.light-gray;
          "gitDecoration.renamedResourceForeground" = config.style.palette.aqua;

          # ----------------------------------------------------------
          # -- gutter and overview ruler
          # ----------------------------------------------------------

          "editorGutter.addedBackground" = config.style.palette.green;
          "editorGutter.modifiedBackground" = config.style.palette.yellow;
          "editorGutter.deletedBackground" = config.style.palette.red;

          "editorOverviewRuler.addedForeground" = "${config.style.palette.green}99";
          "editorOverviewRuler.modifiedForeground" = "${config.style.palette.yellow}99";
          "editorOverviewRuler.deletedForeground" = "${config.style.palette.red}99";
          "editorOverviewRuler.commonContentForeground" = "${config.style.palette.gray}99";
          "editorOverviewRuler.warningForeground" = config.style.palette.orange;

          # ----------------------------------------------------------
          # -- diagnostics
          # ----------------------------------------------------------

          "editorError.foreground" = config.style.palette.red;
          "editorWarning.foreground" = config.style.palette.orange;
          "editorInfo.foreground" = config.style.palette.white;
          "editorHint.foreground" = config.style.palette.light-gray;

          "editor.errorDecoration" = "underline";
          "editor.warningDecoration" = "underline";
          "editor.infoDecoration" = "underline";

          # ----------------------------------------------------------
          # -- search and find
          # ----------------------------------------------------------

          "editor.findMatchForeground" = config.style.palette.black;
          "editor.findMatchBackground" = config.style.palette.green;
          "editor.findMatchBorder" = invisible;

          "editor.findMatchHighlightForeground" = config.style.palette.black;
          "editor.findMatchHighlightBackground" = config.style.palette.white;
          "editor.findMatchHighlightBorder" = invisible;

          # ----------------------------------------------------------
          # -- debug
          # ----------------------------------------------------------

          "debugToolBar.background" = config.style.palette.dark-gray;
          "debugToolBar.border" = invisible;

          "textLink.foreground" = config.style.palette.blue;
          "textLink.activeForeground" = config.style.palette.blue;
          "textLink.border" = invisible;

          "debugConsole.infoForeground" = config.style.palette.blue;
          "debugConsole.warningForeground" = config.style.palette.yellow;
          "debugConsole.errorForeground" = config.style.palette.red;
          "debugConsoleLink.foreground" = config.style.palette.blue;

          # ----------------------------------------------------------
          # -- terminal
          # ----------------------------------------------------------

          "terminal.background" = config.style.palette.black;
          "terminal.foreground" = config.style.palette.white;
          "terminal.border" = config.style.palette.dark-gray;
          "terminal.selectionBackground" = config.style.palette.dim-gray;

          "terminal.tab.activeBackground" = config.style.palette.dark-gray;
          "terminal.tab.activeForeground" = config.style.palette.white;
          "terminal.tab.inactiveBackground" = config.style.palette.black;
          "terminal.tab.inactiveForeground" = config.style.palette.light-gray;
          "terminal.tab.activeBorder" = config.style.palette.dark-gray;
          "terminal.tab.activeBorderTop" = config.style.palette.dark-gray;
          "terminal.tab.activeIconForeground" = invisible;
          "terminal.tab.inactiveIconForeground" = invisible;

          "terminal.ansiBlack" = config.style.palette.light-gray;
          "terminal.ansiRed" = config.style.palette.red;
          "terminal.ansiGreen" = config.style.palette.green;
          "terminal.ansiYellow" = config.style.palette.yellow;
          "terminal.ansiBlue" = config.style.palette.blue;
          "terminal.ansiMagenta" = config.style.palette.purple;
          "terminal.ansiCyan" = config.style.palette.aqua;
          "terminal.ansiWhite" = config.style.palette.white;

          "terminal.ansiBrightBlack" = config.style.palette.light-gray;
          "terminal.ansiBrightRed" = config.style.palette.red;
          "terminal.ansiBrightGreen" = config.style.palette.green;
          "terminal.ansiBrightYellow" = config.style.palette.yellow;
          "terminal.ansiBrightBlue" = config.style.palette.blue;
          "terminal.ansiBrightMagenta" = config.style.palette.purple;
          "terminal.ansiBrightCyan" = config.style.palette.aqua;
          "terminal.ansiBrightWhite" = config.style.palette.white;

          # ----------------------------------------------------------
          # -- hover and word highlight
          # ----------------------------------------------------------

          "editor.wordHighlightBackground" = "${config.style.palette.blue}2E";
          "editor.wordHighlightStrongBackground" = "${config.style.palette.blue}2E";

          "editorHoverWidget.background" = config.style.palette.dark-gray;
          "editorHoverWidget.foreground" = config.style.palette.white;
          "editorHoverWidget.border" = invisible;

          # ----------------------------------------------------------
          # -- suggest widget
          # ----------------------------------------------------------

          "suggestWidget.background" = config.style.palette.black;
          "suggestWidget.foreground" = config.style.palette.white;
          "suggestWidget.border" = config.style.palette.dark-gray;

          "suggestWidget.selectedBackground" = config.style.palette.dim-gray;
          "suggestWidget.selectedForeground" = config.style.palette.white;

          "suggestWidget.highlightForeground" = config.style.palette.green;
          "suggestWidget.detailForeground" = config.style.palette.white;
          "suggestWidget.documentationFontSize" = 12;

          "suggestWidgetScrollbarSlider.background" = config.style.palette.gray;
          "suggestWidgetScrollbarSlider.hoverBackground" = config.style.palette.light-gray;
          "suggestWidgetScrollbarSlider.activeBackground" = config.style.palette.white;

          # ----------------------------------------------------------
          # -- buttons and badges
          # ----------------------------------------------------------

          "button.background" = config.style.palette.dark-gray;
          "button.foreground" = config.style.palette.white;
          "button.hoverBackground" = config.style.palette.dim-gray;
          "button.border" = invisible;

          "button.secondaryBackground" = invisible;
          "button.secondaryForeground" = config.style.palette.white;

          "badge.background" = config.style.palette.dark-gray;
          "badge.foreground" = config.style.palette.white;

          "extensionButton.background" = config.style.palette.dark-gray;
          "extensionButton.foreground" = config.style.palette.white;
          "extensionButton.hoverBackground" = config.style.palette.dim-gray;
          "extensionButton.prominentBackground" = config.style.palette.dark-gray;
          "extensionButton.prominentForeground" = config.style.palette.white;
          "extensionButton.separator" = config.style.palette.gray;

          # ----------------------------------------------------------
          # -- menus
          # ----------------------------------------------------------

          "menu.background" = config.style.palette.black;
          "menu.foreground" = config.style.palette.white;
          "menu.selectionBackground" = config.style.palette.dim-gray;
          "menu.selectionForeground" = config.style.palette.white;
          "menu.separatorBackground" = config.style.palette.dark-gray;
          "menu.border" = config.style.palette.dark-gray;

          "menubar.background" = config.style.palette.black;
          "menubar.foreground" = config.style.palette.white;
          "menubar.selectionBackground" = config.style.palette.dim-gray;
          "menubar.selectionForeground" = config.style.palette.white;
          "menubar.selectionBorder" = invisible;

          # ----------------------------------------------------------
          # -- notifications
          # ----------------------------------------------------------

          "notifications.background" = config.style.palette.black;
          "notifications.foreground" = config.style.palette.white;
          "notifications.border" = config.style.palette.dark-gray;

          "notificationLink.foreground" = config.style.palette.blue;
          "notificationsInfoIcon.foreground" = config.style.palette.blue;
          "notificationsErrorIcon.foreground" = config.style.palette.red;
          "notificationsWarningIcon.foreground" = config.style.palette.orange;

          # ----------------------------------------------------------
          # -- breadcrumbs
          # ----------------------------------------------------------

          "breadcrumb.background" = config.style.palette.black;
          "breadcrumb.foreground" = config.style.palette.light-gray;
          "breadcrumb.focusForeground" = config.style.palette.white;
          "breadcrumb.activeSelectionForeground" = config.style.palette.white;

          # ----------------------------------------------------------
          # -- diff editor
          # ----------------------------------------------------------

          "diffEditor.insertedTextBackground" = "${config.style.palette.green}33";
          "diffEditor.removedTextBackground" = "${config.style.palette.red}33";

          # ----------------------------------------------------------
          # -- brackets and guides
          # ----------------------------------------------------------

          "editorBracketMatch.background" = invisible;
          "editorBracketMatch.border" = invisible;

          "editorBracketHighlight.foreground1" = config.style.palette.light-gray;
          "editorBracketHighlight.foreground2" = config.style.palette.light-gray;
          "editorBracketHighlight.foreground3" = config.style.palette.light-gray;
          "editorBracketHighlight.foreground4" = config.style.palette.light-gray;
          "editorBracketHighlight.foreground5" = config.style.palette.light-gray;
          "editorBracketHighlight.foreground6" = config.style.palette.light-gray;

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

          "editor.guides.bracketPairs" = config.style.palette.dim-gray;
          "editor.guides.bracketPairsActive" = config.style.palette.dim-gray;
          # ----------------------------------------------------------
          # -- list renderer
          # ----------------------------------------------------------

          "list.activeSelectionBackground" = config.style.palette.dim-gray;
          "list.activeSelectionForeground" = config.style.palette.white;
          "list.activeSelectionIconForeground" = config.style.palette.green;

          "list.inactiveSelectionBackground" = config.style.palette.dark-gray;
          "list.inactiveSelectionForeground" = config.style.palette.white;

          "list.hoverBackground" = config.style.palette.dark-gray;

          "list.foreground" = config.style.palette.white;
          "list.focusForeground" = config.style.palette.white;

          "list.focusOutline" = invisible;

          "tree.indentGuidesStroke" = config.style.palette.white;

          # ----------------------------------------------------------
          # -- suggestion widget internals
          # ----------------------------------------------------------

          "list.highlightForeground" = config.style.palette.white;
          "list.focusHighlightForeground" = config.style.palette.green;

          "editorSuggestWidget.background" = config.style.palette.black;
          "editorSuggestWidget.foreground" = config.style.palette.white;
          "editorSuggestWidget.border" = config.style.palette.dark-gray;

          "editorSuggestWidget.highlightForeground" = config.style.palette.white;

          "editorSuggestWidget.selectedBackground" = config.style.palette.dark-gray;
          "editorSuggestWidget.selectedForeground" = config.style.palette.green;

          "symbolIcon.textForeground" = config.style.palette.white;
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
              settings.foreground = config.style.palette.light-gray;
            }

            # -- comments
            {
              scope = "comment";
              settings.foreground = config.style.palette.light-gray;
            }

            {
              scope = [
                "variable.other.object"
                "variable"
                "variable.parameter"
                "variable.other.readwrite"
              ];
              settings.foreground = config.style.palette.white;
            }

            # -- attributes and properties
            {
              scope = [
                "variable.other.object.property"
                "variable.other.property"
                "entity.other.attribute-name"
                "entity.name.tag"
              ];
              settings.foreground = config.style.palette.white;
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
              settings.foreground = config.style.palette.purple;
            }

            # -- operators
            {
              scope = "keyword.operator";
              settings.foreground = config.style.palette.light-gray;
            }

            # -- namespaces
            {
              scope = [
                "entity.name.scope-resolution"
                "entity.name.namespace"
              ];
              settings.foreground = config.style.palette.aqua;
            }

            # -- types
            {
              scope = [
                "entity.name.type"
                "storage.type"
                "support.type"
              ];
              settings.foreground = config.style.palette.blue;
            }

            # -- storage modifiers
            {
              scope = [
                "storage.modifier"
              ];
              settings.foreground = config.style.palette.blue;
            }

            # -- functions
            {
              scope = [
                "meta.function"
                "entity.name.function"
                "support.function"
              ];
              settings.foreground = config.style.palette.orange;
            }

            # -- structures
            {
              scope = [
                "storage.type.struct"
                "storage.type.class"
              ];
              settings.foreground = config.style.palette.orange;
            }

            # -- templates
            {
              scope = [
                "storage.type.template"
              ];
              settings.foreground = config.style.palette.red;
            }

            # -- strings
            {
              scope = [
                "string"
                "string.quoted"
                "string.template"
                "string.interpolated"
              ];
              settings.foreground = config.style.palette.orange;
            }

            # -- numeric values
            {
              scope = [
                "constant.numeric.float.suffix"
                "constant.numeric"
                "keyword.other.unit.suffix.floating-point"
              ];
              settings.foreground = config.style.palette.purple;
            }

            # -- constants
            {
              scope = [
                "constant.language"
              ];
              settings.foreground = config.style.palette.purple;
            }

            # -- fallback
            {
              scope = [
                "meta"
                "source.cpp"
              ];
              settings.foreground = config.style.palette.white;
            }
          ];
        };
      };
    };
  };
}
