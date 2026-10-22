args @ {
  pkgs,
  sundry,
  lib,
  root,
  flake-file-tree,
  ...
}: let
  decorators = lib.pipe (sundry.vfs.dir.get-relative-to root ./decorators flake-file-tree) [
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
    "alefragnani.pascal"
    "alefragnani.pascal-formatter"
    "jq-syntax-highlighting.jq-syntax-highlighting"
    "mads-hartmann.bash-ide-vscode"
    "tamasfe.even-better-toml"
    "a5huynh.vscode-ron"
    "jnoortheen.nix-ide"
    "dlasagno.rasi"
    "thenuprojectcontributors.vscode-nushell-lang"
    "barsikus007.nix-injection"
    "bbenoist.qml"
    "13xforever.language-x86-64-assembly"

    # -- html live preview
    "ms-vscode.live-server"

    # -- icons
    "miguelsolorio.fluent-icons" # -- product icons
    "jtlowe.vscode-icon-theme" # -- visual studio file icons

    # -- plantuml
    "jebbs.plantuml"
  ];

  # -- needed for plantuml rendering to work
  home.packages = with pkgs; [jdk graphviz];
}
