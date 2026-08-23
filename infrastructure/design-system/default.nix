args @ {
  sundry,
  lib,
  ...
}: {
  files = lib.pipe ./values [
    sundry.vfs.dir.from-src
    sundry.vfs.dir.load-nix
    sundry.vfs.dir.collapse
    (path: file: file.expr args)
  ];
}
