args @ {
  mlem,
  config-root,
  lib,
  pkgs,
  ...
}: let
  pipeline-root = "${config-root}/home-manager/dotfile-symlinking/pipeline";
  src-path = "${config-root}/home-manager/dotfile-symlinking/src";
  pipeline-module-args = args // {inherit src-path;};
  pipeline = lib.pipe pipeline-root [
    mlem.vfs.dir.from-src
    mlem.vfs.dir.path-strs
    (map (path: import "${pipeline-root}/${path}" pipeline-module-args))
    mlem.attrs.merge.recursive.no-collision
  ];
in {
  home.file = (mlem.attrs.resolve-deps pipeline).result;
}
