#!/usr/bin/env bash
# Render every PlantUML file under diagrams/ to a sibling .png.
#
#   render_diagrams.sh [diagrams_dir]
#
# Default diagrams dir is ./diagrams. Missing tooling is pulled in through
# `nix shell` automatically.
#
# PLANTUML_DPI (default 300) sets the raster resolution. PlantUML's default
# output is ~89 DPI, which pixelates once a figure is scaled to 15 cm in the
# report. `-Sdpi` is used because `scale` only applies to SVG.
set -euo pipefail

self="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v plantuml >/dev/null 2>&1; then
  exec nix shell nixpkgs#plantuml nixpkgs#graphviz \
    --command "$self/$(basename "${BASH_SOURCE[0]}")" "$@"
fi

dir="${1:-diagrams}"
mapfile -t files < <(cd "$dir" && ls ./*.puml 2>/dev/null || true)

if [ "${#files[@]}" -eq 0 ]; then
  echo "no .puml files in $dir"
  exit 0
fi

(cd "$dir" && plantuml -tpng -charset UTF-8 -Sdpi="${PLANTUML_DPI:-300}" ./*.puml)

echo "rendered ${#files[@]} diagram(s) in $dir"
