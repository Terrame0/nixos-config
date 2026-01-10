{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    mutableExtensionsDir = false;
    profiles.default = {
      # -- vscode extensions
      extensions = with pkgs.vscode-extensions; [
        pkief.material-icon-theme
        jnoortheen.nix-ide
        charliermarsh.ruff
        mads-hartmann.bash-ide-vscode
        llvm-vs-code-extensions.vscode-clangd
      ];
      # -- settings.json
      userSettings = {
        # -- misc tweaks
        "keyboard.dispatch" = "keyCode";
        "security.workspace.trust.untrustedFiles" = "open";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "telemetry.telemetryLevel" = "off";
        "chat.disableAIFeatures" = true;

        # -- nix linting
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "alejandra";
        "nix.serverPath" = "nixd";
        "nix.hiddenLanguageServerErrors" = ["textDocument/definition"];

        # -- cpp extension config
        "C_Cpp.default.compilerPath" = "clang";
        "C_Cpp.intelliSenseEngine" = "disabled";
        "C_Cpp.default.cppStandard" = "c++23";
        "C_Cpp.default.cStandard" = "c23";

        # -- default terminal emulator
        "terminal.external.linuxExec" = "alacritty";

        # -- disable updates
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;

        # -- cursor appearance
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorBlinking" = "solid";
        "editor.cursorStyle" = "line";

        # -- general appearance
        "workbench.tree.indent" = 20;
        "editor.minimap.enabled" = false;
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Default Dark Modern";

        "material-icon-theme.saturation" = 0;
        "material-icon-theme.hidesExplorerArrows" = false;
        "material-icon-theme.folders.theme" = "classic";
      };
    };
  };
}
