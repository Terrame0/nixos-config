args @ {
  pkgs,
  sundry,
  lib,
  ...
}: let
  decorators = lib.pipe ./${"decorators{private}"} [
    sundry.vfs.dir.from-src
    sundry.vfs.dir.load-nix
    (sundry.vfs.dir.collapse (path: file: file.expr args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscodeExt decorators [
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
    "thenuprojectcontributors.vscode-nushell-lang"
    # "atomicspirit.nix-embedded-highlighter"
    "barsikus007.nix-injection"

    # -- html live preview
    "ms-vscode.live-server"

    # -- plantuml
    "jebbs.plantuml"

    # -- opencode integration (requires system opencode)
    "sst-dev.opencode"
  ];

  # -- needed for plantuml rendering to work
  home.packages = with pkgs; [jdk graphviz];
}
