args @ {
  sundry,
  lib,
  ...
}: let
  mk-type = import ./mk-type.nix args;
  types = lib.pipe ./types [
    sundry.vfs.dir.from-src
    sundry.vfs.dir.load-nix
    (sundry.vfs.dir.collapse (path: file: file.expr (args // {inherit mk-type;})))
    sundry.attrs.merge.recursive.no-collision
  ];
  font-size = types.dimension.px 10;
in
  font-size
