{
  pkgs,
  inputs,
  ...
}: {
  programs.opencode.extraPackages = with pkgs; [
    nushell
    pandoc
    plantuml
    graphviz
    python3
    inputs.idef0-svg-gost.packages.${pkgs.system}.default
  ];
  programs.opencode.skills.gost-report = ./.;
}
