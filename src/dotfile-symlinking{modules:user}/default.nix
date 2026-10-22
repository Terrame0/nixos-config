args @ {
  sundry,
  lib,
  pkgs,
  root,
  flake-file-tree,
  ...
}: let
  pipeline = lib.pipe (sundry.vfs.dir.get-relative-to root ./pipeline flake-file-tree) [
    (sundry.vfs.dir.collapse (path: file: file.expr args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (sundry.attrs.resolve-deps pipeline).home-files;
}
