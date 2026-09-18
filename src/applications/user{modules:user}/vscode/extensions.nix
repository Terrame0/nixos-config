{pkgs, ...}: let
  settings = import ./${"config{dotfiles:.config|Code|User}"}/${"settings{private}"}/tools/nix-embedded-languages.nix {};
  include = settings."nix-embedded-languages.include";

  grammars =
    pkgs.runCommand "nix-embedded-languages-grammars" {
      nativeBuildInputs = [pkgs.bun];
    } ''
      cp -r ${pkgs.fetchFromGitHub {
        owner = "czxtm";
        repo = "vscode-nix-embedded-languages";
        rev = "e0e1324142ea1fb442a0633b4668ffd72d82c379";
        hash = "sha256-n87eVVF2xfeygL1cTI012J3ghZJpDhhVwU0gUZivLI0=";
      }}/. .
      chmod -R u+w .
      cp ${./nix-embedded-languages/custom-generate.ts} src/custom-generate.ts
      CUSTOM_LANGUAGES_JSON=${
        pkgs.writeText "nix-embedded-languages-include.json" (builtins.toJSON include)
      } bun src/custom-generate.ts
      mkdir -p $out
      cp syntaxes/source.nix.injection.tmLanguage.json $out/
      cp syntaxes/source.nix.before-string.injection.tmLanguage.json $out/
    '';

  decorators = {
    "coopermaruyama.nix-embedded-languages".postPatch = ''
      cp ${grammars}/source.nix.injection.tmLanguage.json syntaxes/
      cp ${grammars}/source.nix.before-string.injection.tmLanguage.json syntaxes/
    '';
  };
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
    "coopermaruyama.nix-embedded-languages"

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
