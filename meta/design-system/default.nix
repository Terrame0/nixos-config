args @ {
  sundry,
  lib,
  repo-vfs,
  ...
}: let
  ds-subtree = repo-vfs.meta.design-system;
  mk-type = ds-subtree."mk-type.nix".expr args;
  is-token = ds-subtree."is-token.nix".expr args;
  mk-partial = ds-subtree."mk-partial.nix".expr (args // {inherit tokens is-token;});
  load-parts = sub:
    lib.pipe ds-subtree.${sub} [
      (sundry.vfs.dir.collapse
        (path: file: file.expr (args // {inherit types tokens mk-type is-token mk-partial;})))
      sundry.attrs.merge.recursive.no-collision
    ];
  types = load-parts "types";
  tokens = load-parts "tokens";
in {
  partials-vfs =
    sundry.vfs.dir.resolve-tags
    {"partials{dotfiles:.design-system}" = load-parts "partials";};
  native-tokens =
    sundry.attrs.walk-until is-token
    (path: attrs: attrs.native)
    tokens;
}
