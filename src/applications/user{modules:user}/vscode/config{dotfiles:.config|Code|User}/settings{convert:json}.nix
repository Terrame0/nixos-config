args @ {
  file-dir,
  sundry,
  lib,
  ...
}:
lib.pipe "${file-dir}/settings{parts}" [
  sundry.vfs.dir.from-src
  (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
  (sundry.vfs.dir.collapse (path: file: import file.origin args))
  sundry.attrs.merge.recursive.no-collision
]
