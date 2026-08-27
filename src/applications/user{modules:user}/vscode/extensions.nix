{pkgs, ...}: {
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    # -- cpp
    "twxs.cmake"
    "llvm-vs-code-extensions.vscode-clangd"
    "mesonbuild.mesonbuild"

    # -- direnv
    "mkhl.direnv"

    # -- python
    "ms-python.python"
    "charliermarsh.ruff"

    # -- syntax highlighters
    "jq-syntax-highlighting.jq-syntax-highlighting"
    "mads-hartmann.bash-ide-vscode"
    "tamasfe.even-better-toml"
    "a5huynh.vscode-ron"
    "jnoortheen.nix-ide"
    "dlasagno.rasi"

    # -- codex
    "openai.chatgpt"

    # -- html live preview
    "ms-vscode.live-server"
  ];
}
