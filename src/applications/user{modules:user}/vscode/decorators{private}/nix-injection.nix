{pkgs, ...}: let
  src = pkgs.fetchFromGitHub {
    owner = "barsikus007";
    repo = "vscode-nix-injection";
    rev = "f367ed0935a21b6850f72dbefcb6550a0fee3bae";
    hash = "sha256-f83lGXuUm8HBVanMOGmkLK8la2V0HIFSQMar/9z2IFA=";
  };
  additions =
    builtins.fromJSON
    # -< json >-
    ''
      [
        { "key": "nushell", "triggers": ["nushell", "nu"], "scope": "source.nushell", "langId": "nushell" },
        { "key": "rasi", "triggers": ["rasi"], "scope": "source.rasi", "langId": "rasi" },
        { "key": "qml", "triggers": ["qml"], "scope": "source.qml", "langId": "qml" },
        { "key": "ron", "triggers": ["ron"], "scope": "source.ron", "langId": "ron" },
        { "key": "plantuml", "triggers": ["plantuml", "puml", "wsd"], "scope": "source.wsd", "langId": "plantuml" },
        { "key": "jq", "triggers": ["jq"], "scope": "source.jq", "langId": "jq" },
        { "key": "meson", "triggers": ["meson"], "scope": "source.meson", "langId": "meson" },
        { "key": "cmake", "triggers": ["cmake"], "scope": "source.cmake", "langId": "cmake" },
        { "key": "requirements", "triggers": ["requirements", "pip"], "scope": "source.pip-requirements", "langId": "pip-requirements" }
      ]
    '';
  upstream = builtins.fromJSON (builtins.readFile "${src}/languages.json");
  inherit (builtins.fromJSON (builtins.readFile "${src}/package.json")) version;
  keys = map (l: l.key) additions;
  merged = additions ++ builtins.filter (l: !(builtins.elem l.key keys)) upstream;
in {
  "barsikus007.nix-injection".vsix = pkgs.nuenv.mkDerivation {
    name = "nix-injection-${version}.vsix";
    inherit src;
    packages = [pkgs.bun pkgs.zip pkgs.coreutils];
    build =
      # -< nushell >-
      ''
        ^chmod -R u+w .
        cp ${pkgs.writeText "languages.json" (builtins.toJSON merged)} languages.json
        bun scripts/generate.js
        cp ${../patches/patch-grammar.mjs} patch-grammar.mjs
        bun patch-grammar.mjs
        mkdir extension
        cp -r package.json README.md LICENSE languages.json syntaxes extension/
        ^zip -r $env.out extension
      '';
  };
}
