args @ {
  pkgs,
  sundry,
  root,
  flake-file-tree,
  inputs,
  host,
  ...
}: let
  config-file-tree = sundry.vfs.tree.get-relative-to root ./config flake-file-tree;
  opencode-wrapped = pkgs.symlinkJoin {
    name = "opencode-with-experimental";
    paths = [pkgs.opencode];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/opencode --set OPENCODE_EXPERIMENTAL_LSP_TOOL true
    '';
  };
in {
  programs.opencode = {
    enable = true;
    package = opencode-wrapped;
    skills = inputs.clanker-skill-index.skills.${host.system};
    context = config-file-tree."AGENTS.md".origin;
    settings = config-file-tree."settings.nix".expr args;
    extraPackages =
      inputs.clanker-skill-index.requirements.${host.system}
      ++ (with pkgs; [statix fd]);
  };
}
