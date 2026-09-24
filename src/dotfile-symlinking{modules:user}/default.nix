args @ {
  sundry,
  lib,
  pkgs,
  root-vfs,
  ...
}: let
  pipeline = lib.pipe (sundry.vfs.dir.get ./pipeline root-vfs) [
    (sundry.vfs.dir.collapse (path: file: file.expr args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (sundry.attrs.resolve-deps pipeline).home-files;
}
