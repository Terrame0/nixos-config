{pkgs, ...}: let
  src = pkgs.fetchFromGitHub {
    owner = "barsikus007";
    repo = "vscode-nix-injection";
    rev = "f367ed0935a21b6850f72dbefcb6550a0fee3bae";
    hash = "sha256-f83lGXuUm8HBVanMOGmkLK8la2V0HIFSQMar/9z2IFA=";
  };
  additions = builtins.fromJSON ''
    // syntax: json
    [
      { "key": "nushell", "triggers": ["nushell", "nu"], "scope": "source.nushell", "langId": "nushell" },
      { "key": "rasi", "triggers": ["rasi"], "scope": "source.rasi", "langId": "rasi" }
    ]
  '';
  upstream = builtins.fromJSON (builtins.readFile "${src}/languages.json");
  inherit (builtins.fromJSON (builtins.readFile "${src}/package.json")) version;
  keys = map (l: l.key) additions;
  merged = additions ++ builtins.filter (l: !(builtins.elem l.key keys)) upstream;
in {
  "barsikus007.nix-injection".vsix =
    pkgs.runCommand "nix-injection-${version}.vsix" {
      nativeBuildInputs = [pkgs.bun pkgs.zip];
    } ''
      cp -r ${src}/. .
      chmod -R u+w .
      cp ${pkgs.writeText "languages.json" (builtins.toJSON merged)} languages.json
      bun scripts/generate.js
      mkdir extension
      cp -r package.json README.md LICENSE languages.json syntaxes extension/
      zip -r $out extension
    '';
}
