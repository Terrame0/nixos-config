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
  tokens = lib.pipe ./tokens [
    sundry.vfs.dir.from-src
    sundry.vfs.dir.load-nix
    (sundry.vfs.dir.reform (path: file: {
      path = sundry.vfs.path.set.ext "" path;
      value = file.expr (args // {inherit types tokens;});
    }))
  ];
in {inherit tokens types;}
