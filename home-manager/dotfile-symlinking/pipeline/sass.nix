{
  sundry,
  lib,
  pkgs,
  ...
}: {
  sass-staging-dir = {
    deps = ["tags-stripped"];
    transform = prev:
      lib.pipe prev.tags-stripped [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "scss"))
        (sundry.vfs.dir.materialize "sass-build-dir")
      ];
  };

  sass-load-paths = {
    deps = ["sass-staging-dir"];
    transform = prev:
      lib.pipe prev.sass-staging-dir [
        (sundry.vfs.dir.filter-by-tag {i = "sass";})
        (sundry.vfs.dir.collapse (path: file:
          lib.pipe path [
            (lib.sublist 0 (sundry.vfs.file.get-tag-pos {i = "sass";} file))
            sundry.vfs.path.get.str
            (path: "--load-path='${sundry.vfs.path.get.str [file.base path]}'")
          ]))
        (lib.concatStringsSep " ")
      ];
  };

  sass = {
    deps = ["sass-staging-dir" "sass-load-paths"];
    transform = prev:
      lib.pipe prev.sass-staging-dir [
        (sundry.vfs.dir.filter-by-tag {build = "sass";})
        (sundry.vfs.dir.reform (path: file: {
          path = sundry.vfs.path.set.ext "css" path;
          value =
            file
            // {
              src =
                pkgs.runCommand "bruh" {buildInputs = [pkgs.dart-sass];}
                "sass '${file.src}' $out --no-source-map ${prev.sass-load-paths} --quiet";
            };
        }))
      ];
  };
}
