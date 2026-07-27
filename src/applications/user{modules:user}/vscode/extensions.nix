{pkgs, ...}: {
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    "tamasfe.even-better-toml"
    "twxs.cmake"
    "ms-python.python"
    "jnoortheen.nix-ide"
    "charliermarsh.ruff"
    "mads-hartmann.bash-ide-vscode"
    "llvm-vs-code-extensions.vscode-clangd"
    "mesonbuild.mesonbuild"
    "openai.chatgpt"
    "a5huynh.vscode-ron"
    "jq-syntax-highlighting.jq-syntax-highlighting"
  ];
}
