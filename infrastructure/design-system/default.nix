args @ {
  sundry,
  lib,
  ...
}: let
  mk-type = import ./mk-type.nix args;
  is-token = import ./is-token.nix args;
  types = load-parts ./types;
  tokens = load-parts ./tokens;
  partials = load-parts ./partials;
  load-parts = path:
    lib.pipe path [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.load-nix
      (sundry.vfs.dir.collapse (path: file: file.expr (args // {inherit types tokens mk-type is-token;})))
      sundry.attrs.merge.recursive.no-collision
    ];
in {inherit partials tokens types;}
