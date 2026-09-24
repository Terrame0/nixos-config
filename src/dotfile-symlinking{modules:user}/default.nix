args @ {
  sundry,
  lib,
  pkgs,
  root-vfs,
  ...
}: let
  pipeline = lib.pipe root-vfs.src.dotfile-symlinking.pipeline [
    (sundry.vfs.dir.collapse (path: file: file.expr args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (sundry.attrs.resolve-deps pipeline).home-files;
}
