{
  sundry,
  lib,
  ...
}: {
  result = {
    deps = ["sass" "nix" "processed-imports"];
    transform = prev:
      lib.pipe prev [
        lib.attrValues
        sundry.attrs.merge.recursive.no-collision
        (sundry.vfs.dir.reform-within-tag
          (_: with _; tag {ext = [];})
          (path: file: {
            path = sundry.vfs.path.set.ext (lib.last file.tag-list).ext path;
            value = file;
          }))
        (sundry.vfs.dir.collapse (path: file: {
          ${sundry.vfs.path.get.str path} =
            if file ? text
            then {text = file.text;}
            else {source = file.origin;};
        }))
        sundry.attrs.merge.recursive.no-collision
      ];
  };
}
