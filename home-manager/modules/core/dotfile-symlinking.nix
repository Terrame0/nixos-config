args @ {
  sundry,
  config-root,
  lib,
  pkgs,
  ...
}: let
  pipeline-root = "${config-root}/home-manager/dotfile-symlinking/pipeline";
  src-path = "${config-root}/home-manager/dotfile-symlinking/src";
  pipeline-module-args = args // {inherit src-path;};
  pipeline = lib.pipe pipeline-root [
    sundry.vfs.dir.from-src
    sundry.vfs.dir.path-strs
    (map (path: import "${pipeline-root}/${path}" pipeline-module-args))
    sundry.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (sundry.attrs.resolve-deps pipeline).result;
}
