args @ {
  sundry,
  lib,
  ...
}: let
  mk-type = import ./mk-type.nix args;
  is-token = import ./is-token.nix args;
  mk-partial = import ./mk-partial.nix (args // {inherit tokens is-token;});
  load-parts = path:
    lib.pipe path [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.load-nix
      (sundry.vfs.dir.collapse (path: file: file.expr (args // {inherit types tokens mk-type is-token mk-partial;})))
      sundry.attrs.merge.recursive.no-collision
    ];
  types = load-parts ./types;
  tokens = load-parts ./tokens;
  partials = load-parts ./partials;
  partials-vfs = sundry.vfs.dir.resolve-tags {
    "partials{dotfiles:.design-system}" = partials;
  };
  native = lib.pipe tokens [
    (sundry.attrs.walk-until is-token (path: attrs: attrs.value))
  ];
in {inherit partials-vfs native;}
