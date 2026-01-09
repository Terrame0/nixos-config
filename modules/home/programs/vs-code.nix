{pkgs, ...}: {
  xdg.configFile."Code/User/settings.json" = {
    source = ../program-configurations/vscode-settings.json;
    force = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    mutableExtensionsDir = false;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
      jnoortheen.nix-ide
      charliermarsh.ruff
      mads-hartmann.bash-ide-vscode
      llvm-vs-code-extensions.vscode-clangd
    ];
  };
}
