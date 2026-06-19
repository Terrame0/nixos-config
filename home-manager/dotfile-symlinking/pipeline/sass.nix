{
  sundry,
  lib,
  pkgs,
  ...
}: {
  sass = {
    deps = ["tags-stripped"];
    transform = prev:
      lib.pipe prev.tags-stripped [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "scss"))
        (sundry.vfs.dir.materialize "sass-build-dir")
        (sundry.vfs.dir.by-tag.reform {build = "sass";}
          (path: tag-pos: file: {
            path = sundry.vfs.path.set.ext "css" path;
            value =
              file
              // {
                src =
                  pkgs.runCommand "bruh" {buildInputs = [pkgs.dart-sass];}
                  "sass '${file.src}' $out --no-source-map --quiet";
              };
          }))
      ];
  };

  result = {
    deps = ["sass"];
    transform = prev:
      lib.pipe prev [
        (lib.mapAttrsToList
          (name: value:
            sundry.attrs.merge.recursive.no-collision
            (sundry.vfs.dir.collapse (path: file: {
                "test-dir/${name}/${sundry.vfs.path.get.str path}" =
                  if file ? text
                  then {text = file.text;}
                  else {source = file.src;};
              })
              value)))
        sundry.attrs.merge.recursive.no-collision
      ];
  };
}
