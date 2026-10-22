args @ {
  sundry,
  lib,
  root,
  flake-file-tree,
  ...
}:
lib.pipe (sundry.vfs.dir.get-relative-to root ./settings flake-file-tree) [
  (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
  (sundry.vfs.dir.collapse (path: file: file.expr args))
  sundry.attrs.merge.recursive.no-collision
]
