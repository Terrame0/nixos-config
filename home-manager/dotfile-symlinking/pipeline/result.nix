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
