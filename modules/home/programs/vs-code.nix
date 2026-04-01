{pkgs, ...}: {
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
        "mesonbuild.mesonbuild"
      ];
    in {
      extensions = marketplace-extensions;
    };
  };
}
