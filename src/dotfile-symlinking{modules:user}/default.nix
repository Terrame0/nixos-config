args @ {
  sundry,
  lib,
  pkgs,
  flake-file-tree,
  ...
}: let
  pipeline = lib.pipe (sundry.vfs.dir.get ./pipeline flake-file-tree) [
    (sundry.vfs.dir.collapse (path: file: file.expr args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (sundry.attrs.resolve-deps pipeline).home-files;
}
