{
  sundry,
  lib,
  pkgs,
  ...
}: {
  sass-staging-dir = {
    deps = ["imports"];
    transform = prev:
      lib.pipe prev.imports [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "scss"))
        (sundry.vfs.dir.materialize "sass-build-dir")
      ];
  };

  sass-load-paths = {
    deps = ["sass-staging-dir"];
    transform = prev:
      lib.pipe prev.sass-staging-dir [
        (sundry.vfs.dir.select-by-tag (_: with _; tag {include = "sass";}))
        (sundry.vfs.dir.collapse (path: file: let
          tag-pos = sundry.vfs.file.get-tag-pos (_: with _; tag {include = "sass";}) file;
        in "--load-path='${sundry.vfs.path.get.str ([file.drv-path] ++ (lib.take tag-pos path))}'"))
        lib.unique
        (lib.concatStringsSep " ")
        (sundry.debug)
      ];
  };

  sass = {
    deps = ["sass-staging-dir" "sass-load-paths"];
    transform = prev:
      lib.pipe prev.sass-staging-dir [
        (sundry.vfs.dir.select-by-tag (_: with _; tag {build = "sass";}))
        (sundry.vfs.dir.reform (path: file: {
          path = sundry.vfs.path.set.ext "css" path;
          value =
            file
            // {
              origin =
                pkgs.runCommand "build-sass" {buildInputs = [pkgs.dart-sass];}
                "sass '${file.origin}' $out --no-source-map ${prev.sass-load-paths} --quiet";
            };
        }))
      ];
  };
}
