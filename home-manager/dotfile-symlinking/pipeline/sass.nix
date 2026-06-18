{
  mlem,
  lib,
  pkgs,
  ...
}: {
  sass = {
    deps = ["tags-stripped"];
    transform = prev:
      lib.pipe prev.tags-stripped [
        (mlem.vfs.dir.filter (path: file: mlem.vfs.path.get.ext path == "scss"))
        (mlem.vfs.dir.materialize "sass-build-dir")
        (mlem.vfs.dir.by-tag.reform {build = "sass";}
          (path: tag-pos: file: {
            path = mlem.vfs.path.set.ext "css" path;
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
            mlem.attrs.merge.recursive.no-collision
            (mlem.vfs.dir.collapse (path: file: {
                "test-dir/${name}/${mlem.vfs.path.get.str path}" =
                  if file ? text
                  then {text = file.text;}
                  else {source = file.src;};
              })
              value)))
        mlem.attrs.merge.recursive.no-collision
      ];
  };
}
