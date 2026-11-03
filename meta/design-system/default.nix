meta-args @ {
  sundry,
  lib,
  flake-file-tree,
  ...
}: let
  ds-file-tree = flake-file-tree.meta.design-system;
  consumers = ["css" "lua" "qml" "rasi" "scss"];
  mk-type = ds-file-tree."mk-type.nix".expr (meta-args // {inherit consumers;});
  is-token = ds-file-tree."is-token.nix".expr meta-args;
  mk-partial =
    ds-file-tree."mk-partial.nix".expr (meta-args // {inherit tokens is-token consumers;});
  load-parts = sub:
    lib.pipe ds-file-tree.${sub} [
      (sundry.vfs.tree.collapse
        (path: file:
          file.expr (meta-args
            // {
              inherit types tokens mk-type is-token mk-partial consumers;
            })))
      sundry.attrs.merge.recursive.no-collision
    ];
  types = load-parts "types";
  tokens = load-parts "tokens";
in {
  partials-file-tree = load-parts "partials";
  native-tokens =
    sundry.attrs.walk-until is-token
    (path: attrs: attrs.native)
    tokens;
}
