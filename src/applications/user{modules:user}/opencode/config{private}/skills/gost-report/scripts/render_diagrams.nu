#!/usr/bin/env nu

# Render diagrams under a directory to sibling .png files.
#
#   render_diagrams.nu [diagrams_dir]
#
# Two source types are handled:
#   *.puml   PlantUML      → .png            (PLANTUML_DPI, default 300)
#   *.idef0  IDEF0-SVG     → .svg and .png   (IDEF0_DPI, default 300)
#
# The `.idef0` path runs `schematic` (from IDEF0-SVG-GOST-wrapped) to get an SVG,
# then rasterizes it with `resvg`. The SVG is kept next to the model so the PNG
# can be re-rendered at another DPI without re-running schematic.
#
# Default diagrams dir is ./diagrams. Missing tooling is pulled in through
# `nix shell` automatically; `schematic` comes from the wrapper's flake.

def render-puml [dir: path, dpi: string]: nothing -> int {
  let files = (glob $"($dir)/*.puml")
  if ($files | is-empty) { return 0 }
  ^plantuml -tpng -charset UTF-8 $"-Sdpi=($dpi)" ...$files
  $files | length
}

def render-idef0 [dir: path, dpi: string]: nothing -> int {
  let files = (glob $"($dir)/*.idef0")
  for model in $files {
    let stem = ($model | path parse | get stem)
    let svg = ($dir | path join $"($stem).svg")
    open --raw $model | ^schematic o> $svg
    ^resvg --dpi $dpi $svg ($dir | path join $"($stem).png")
  }
  $files | length
}

def main [dir: path = "diagrams"] {
  if (which plantuml | is-empty) or (which schematic | is-empty) or (which resvg | is-empty) {
    ^nix shell nixpkgs#plantuml nixpkgs#graphviz nixpkgs#resvg github:Terrame0/IDEF0-SVG-GOST-wrapped --command $nu.current-exe $env.CURRENT_FILE $dir
    return
  }

  let puml_dpi = ($env | get -o PLANTUML_DPI | default "300")
  let idef0_dpi = ($env | get -o IDEF0_DPI | default "300")

  let n_puml = (render-puml $dir $puml_dpi)
  let n_idef0 = (render-idef0 $dir $idef0_dpi)

  if ($n_puml + $n_idef0) == 0 {
    print $"no .puml or .idef0 files in ($dir)"
    return
  }
  print $"rendered ($n_puml) PlantUML and ($n_idef0) IDEF0 diagram\(s\) in ($dir)"
}
