args @ {
  sundry,
  lib,
  root-vfs,
  ...
}:
lib.pipe (sundry.vfs.dir.get ./settings root-vfs) [
  (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
  (sundry.vfs.dir.collapse (path: file: file.expr args))
  sundry.attrs.merge.recursive.no-collision
]
