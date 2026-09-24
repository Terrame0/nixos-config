args @ {
  sundry,
  lib,
  vfs,
  ...
}: let
  mk-type = vfs."mk-type.nix".expr args;
  is-token = vfs."is-token.nix".expr args;
  mk-partial = vfs."mk-partial.nix".expr (args // {inherit tokens is-token;});
  load-parts = sub:
    lib.pipe vfs.${sub} [
      (sundry.vfs.dir.collapse (path: file: file.expr (args // {inherit types tokens mk-type is-token mk-partial;})))
      sundry.attrs.merge.recursive.no-collision
    ];
  types = load-parts "types";
  tokens = load-parts "tokens";
  partials = load-parts "partials";
  partials-vfs =
    sundry.vfs.dir.resolve-tags
    {"partials{dotfiles:.design-system}" = partials;};
  native = lib.pipe tokens [
    (sundry.attrs.walk-until is-token (path: attrs: attrs.value))
  ];
in {inherit partials-vfs native;}
