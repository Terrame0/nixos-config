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
        (sundry.vfs.dir.select-by-tag (_: with _; tag {i = "sass";}))
        (sundry.vfs.dir.collapse (path: file: "--load-path='${file.origin}'"))
        (lib.concatStringsSep " ")
      ];
  };

  sass = {
    deps = ["sass-staging-dir" "sass-load-paths"];
    transform = prev:
      lib.pipe prev.sass-staging-dir [
        (sundry.vfs.dir.reform-within-tag (_: with _; tag {build = "sass";}) (path: file: {
          path = sundry.vfs.path.set.ext "css" path;
          value =
            file
            // {
              origin =
                pkgs.runCommand "bruh" {buildInputs = [pkgs.dart-sass];}
                "sass '${file.origin}' $out --no-source-map ${sundry.debug prev.sass-load-paths} --quiet";
            };
        }))
      ];
  };
}
