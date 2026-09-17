#!/usr/bin/env nu

# Render the diagram sources named on the command line to sibling PNGs.
#
#   render_diagrams.nu <file>...
#
# Every path must end in .puml or .idef0:
#   *.puml   PlantUML      → .png            (PLANTUML_DPI, default 300)
#   *.idef0  IDEF0-SVG     → .svg and .png   (IDEF0_DPI, default 300)
#
# Paths are taken verbatim: the script never scans a directory, so a scratch
# model is rendered — or can break the run — only when it is named explicitly.
#
# The `.idef0` path runs `schematic` (from IDEF0-SVG-GOST-wrapped) to get an SVG,
# then rasterizes it with `resvg`. The SVG is kept next to the model so the PNG
# can be re-rendered at another DPI without re-running schematic.
#
# Missing tooling is pulled in through `nix shell` automatically; `schematic`
# comes from the wrapper's flake.

def extension [f: path]: nothing -> string {
  $f | path parse | get extension | str downcase
}

def render-puml [files: list<path>, dpi: string]: nothing -> int {
  if ($files | is-empty) { return 0 }
  ^plantuml -tpng -charset UTF-8 $"-Sdpi=($dpi)" ...$files
  $files | length
}

def render-idef0 [files: list<path>, dpi: string]: nothing -> int {
  for model in $files {
    let dir = ($model | path dirname)
    let stem = ($model | path parse | get stem)
    let svg = ($dir | path join $"($stem).svg")
    open --raw $model | ^schematic o> $svg
    ^resvg --dpi $dpi $svg ($dir | path join $"($stem).png")
  }
  $files | length
}

def main [...files: path] {
  if ($files | is-empty) {
    error make {msg: "render_diagrams.nu: name at least one .puml or .idef0 file"}
  }

  let unsupported = ($files | where {|f| (extension $f) not-in ["puml" "idef0"]})
  if not ($unsupported | is-empty) {
    error make {msg: $"render_diagrams.nu: not a .puml or .idef0 path: ($unsupported | str join ', ')"}
  }

  if (which plantuml | is-empty) or (which schematic | is-empty) or (which resvg | is-empty) {
    ^nix shell nixpkgs#plantuml nixpkgs#graphviz nixpkgs#resvg github:Terrame0/IDEF0-SVG-GOST-wrapped --command $nu.current-exe $env.CURRENT_FILE ...$files
    return
  }

  let puml_dpi = ($env | get -o PLANTUML_DPI | default "300")
  let idef0_dpi = ($env | get -o IDEF0_DPI | default "300")

  let puml = ($files | where {|f| (extension $f) == "puml"})
  let idef0 = ($files | where {|f| (extension $f) == "idef0"})

  let n_puml = (render-puml $puml $puml_dpi)
  let n_idef0 = (render-idef0 $idef0 $idef0_dpi)

  print $"rendered ($n_puml) PlantUML and ($n_idef0) IDEF0 diagram\(s\)"
}
