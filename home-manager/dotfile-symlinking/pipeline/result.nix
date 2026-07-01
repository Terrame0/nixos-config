{
  sundry,
  lib,
  ...
}: {
  result = {
    deps = [
      "sass"
      "nix"
      "processed-imports"
    ];
    transform = prev:
      lib.pipe prev [
        (lib.mapAttrsToList
          (name: value:
            sundry.attrs.merge.recursive.no-collision
            (sundry.vfs.dir.collapse (path: file: {
                "test-dir/${name}/${sundry.vfs.path.get.str path}" =
                  if file ? text
                  then {text = file.text;}
                  else {source = file.origin;};
              })
              value)))
        sundry.attrs.merge.recursive.no-collision
      ];
  };
}
