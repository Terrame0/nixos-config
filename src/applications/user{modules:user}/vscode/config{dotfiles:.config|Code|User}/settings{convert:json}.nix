args @ {
  sundry,
  lib,
  root,
  flake-file-tree,
  ...
}:
lib.pipe (sundry.vfs.tree.get-relative-to root ./settings flake-file-tree) [
  (sundry.vfs.tree.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
  (sundry.vfs.tree.collapse (path: file: file.expr args))
  sundry.attrs.merge.recursive.no-collision
]
