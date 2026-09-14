#!/usr/bin/env bash
# Build a GOST-formatted .docx from a markdown report.
#
#   build.sh <report.md> [out.docx] [--titlepage <titlepage>]
#
# The optional title page is either a markdown fragment (custom-style divs,
# concatenated in front of the report by pandoc) or a .docx (its paragraphs are
# spliced in verbatim after pandoc, so the layout is reproduced exactly).
# Diagrams referenced from the markdown (e.g. diagrams/org.png) must be rendered
# first with render_diagrams.sh. Missing tooling is pulled in through `nix shell`
# automatically.
set -euo pipefail

self="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v pandoc >/dev/null 2>&1; then
  exec nix shell nixpkgs#pandoc --command "$self/$(basename "${BASH_SOURCE[0]}")" "$@"
fi

titlepage=""
positional=()
while [ "$#" -gt 0 ]; do
  case "$1" in
    -t|--titlepage)
      titlepage="${2:?--titlepage needs a file}"
      shift 2
      ;;
    --)
      shift
      positional+=("$@")
      break
      ;;
    *)
      positional+=("$1")
      shift
      ;;
  esac
done

src="${positional[0]:?usage: build.sh <report.md> [out.docx] [--titlepage <titlepage>]}"
out="${positional[1]:-${src%.md}.docx}"

inputs=("$src")
titlepage_docx=""
case "$titlepage" in
  "")
    ;;
  *.docx)
    titlepage_docx="$titlepage"
    ;;
  *)
    inputs=("$titlepage" "$src")
    ;;
esac

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

pandoc --print-default-data-file reference.docx > "$work/base.docx"
python3 "$self/gost_reference.py" "$work/reference_gost.docx" "$work/base.docx"
pandoc "${inputs[@]}" --reference-doc="$work/reference_gost.docx" -o "$work/out.docx"
if [ -n "$titlepage_docx" ]; then
  python3 "$self/gost_postprocess.py" "$work/out.docx" "$out" --titlepage "$titlepage_docx"
else
  python3 "$self/gost_postprocess.py" "$work/out.docx" "$out"
fi

echo "written: $out"
