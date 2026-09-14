#!/usr/bin/env bash
# Build a GOST-formatted .docx from a markdown report.
#
#   build.sh <report.md> [out.docx]
#
# Diagrams referenced from the markdown (e.g. diagrams/org.png) must be
# rendered first with render_diagrams.sh. Missing tooling is pulled in
# through `nix shell` automatically.
set -euo pipefail

self="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v pandoc >/dev/null 2>&1; then
  exec nix shell nixpkgs#pandoc --command "$self/$(basename "${BASH_SOURCE[0]}")" "$@"
fi

src="${1:?usage: build.sh <report.md> [out.docx]}"
out="${2:-${src%.md}.docx}"

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

pandoc --print-default-data-file reference.docx > "$work/base.docx"
python3 "$self/gost_reference.py" "$work/reference_gost.docx" "$work/base.docx"
pandoc "$src" --reference-doc="$work/reference_gost.docx" -o "$work/out.docx"
python3 "$self/gost_postprocess.py" "$work/out.docx" "$out"

echo "written: $out"
