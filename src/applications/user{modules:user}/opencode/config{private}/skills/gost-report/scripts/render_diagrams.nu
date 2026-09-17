#!/usr/bin/env nu

# Render every PlantUML file under a diagrams directory to a sibling .png.
#
#   render_diagrams.nu [diagrams_dir]
#
# Default diagrams dir is ./diagrams. Missing tooling is pulled in through
# `nix shell` automatically.
#
# PLANTUML_DPI (default 300) sets the raster resolution: PlantUML's native PNG
# is ~89 DPI and pixelates once a figure is scaled to page width. `-Sdpi` is
# used because `scale` only applies to SVG.

def main [dir: path = "diagrams"] {
  if (which plantuml | is-empty) {
    ^nix shell nixpkgs#plantuml nixpkgs#graphviz --command $nu.current-exe $env.CURRENT_FILE $dir
    return
  }

  let files = (glob $"($dir)/*.puml")
  if ($files | is-empty) {
    print $"no .puml files in ($dir)"
    return
  }

  let dpi = ($env | get -o PLANTUML_DPI | default "300")
  ^plantuml -tpng -charset UTF-8 $"-Sdpi=($dpi)" ...$files
  print $"rendered ($files | length) diagram\(s\) in ($dir)"
}
