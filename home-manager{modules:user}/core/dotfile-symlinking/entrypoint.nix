args @ {
  sundry,
  lib,
  config-root,
  pkgs,
  ...
}: let
  pipeline-root = ./${"pipeline{x}"};
  pipeline = lib.pipe pipeline-root [
    sundry.vfs.dir.from-src
    (sundry.vfs.dir.collapse (path: file: import file.origin args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (sundry.attrs.resolve-deps pipeline).result;
}
