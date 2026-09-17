#!/usr/bin/env nu

# Build a GOST-formatted .docx from a markdown report.
#
#   build.nu <report.md> [out.docx] [--titlepage <titlepage>]
#
# The optional title page is either a markdown fragment (custom-style divs,
# concatenated in front of the report by pandoc) or a .docx (its paragraphs are
# spliced in verbatim after pandoc, so the layout is reproduced exactly).
# Diagrams referenced from the markdown (e.g. diagrams/org.png) must be rendered
# first with render_diagrams.nu. Missing tooling is pulled in through
# `nix shell` automatically.

def main [
  src: path
  out?: path
  --titlepage (-t): path
] {
  if ((which pandoc | is-empty) or (which python3 | is-empty)) {
    let pos = if $out == null { [$src] } else { [$src $out] }
    let tp = if $titlepage == null { [] } else { [--titlepage $titlepage] }
    ^nix shell nixpkgs#pandoc nixpkgs#python3 --command $nu.current-exe $env.CURRENT_FILE ...$pos ...$tp
    return
  }

  let script_dir = ($env.CURRENT_FILE | path dirname)
  let final = if $out == null {
    ($src | str replace --regex '\.md$' '') + ".docx"
  } else {
    $out
  }

  let is_docx = ($titlepage != null) and ($titlepage | str ends-with ".docx")
  let inputs = if ($titlepage != null) and (not $is_docx) {
    [$titlepage $src]
  } else {
    [$src]
  }

  let work = (^mktemp -d | str trim)
  let base_docx = ($work | path join "base.docx")
  let ref_docx = ($work | path join "reference_gost.docx")
  let raw_docx = ($work | path join "out.docx")
  let reference_py = ($script_dir | path join "gost_reference.py")
  let postprocess_py = ($script_dir | path join "gost_postprocess.py")

  try {
    ^pandoc --print-default-data-file reference.docx o> $base_docx
    ^python3 -B $reference_py $ref_docx $base_docx
    ^pandoc ...$inputs --reference-doc $ref_docx -o $raw_docx
    if $is_docx {
      ^python3 -B $postprocess_py $raw_docx $final --titlepage $titlepage
    } else {
      ^python3 -B $postprocess_py $raw_docx $final
    }
    print $"written: ($final)"
  } finally {
    rm -rf $work
  }
}
