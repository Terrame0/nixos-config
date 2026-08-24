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
    (sundry.vfs.dir.collapse (path: file: {
      ${sundry.vfs.path.get.stem path} = file.expr (args // {inherit types;});
    }))
    sundry.attrs.merge.recursive.no-collision
  ];
in {inherit tokens types;}
