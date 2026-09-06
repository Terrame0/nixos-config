{
  sundry,
  lib,
  pkgs,
  ...
}: {
  sass-build-tree = {
    deps = ["dotfile-sources"];
    transform = prev:
      lib.pipe prev.dotfile-sources [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "scss"))
        (sundry.vfs.dir.materialize "sass-build-dir")
      ];
  };

  sass-load-flags = {
    deps = ["sass-build-tree"];
    transform = prev:
      lib.pipe prev.sass-build-tree.dir [
        (sundry.vfs.dir.select-by-tag (_: with _; tag {include = "sass";}))
        (sundry.vfs.dir.collapse (path: file: let
          tag-pos = sundry.vfs.file.get-tag-pos (_: with _; tag {include = "sass";}) file;
        in "--load-path='${sundry.vfs.path.get.str ([prev.sass-build-tree.drv] ++ (lib.take tag-pos path))}'"))
        lib.unique
        (lib.concatStringsSep " ")
      ];
  };

  built-sass-dotfiles = {
    deps = ["sass-build-tree" "sass-load-flags"];
    transform = prev:
      lib.pipe prev.sass-build-tree.dir [
        (sundry.vfs.dir.select-by-tag (_: with _; tag {build = "sass";}))
        (sundry.vfs.dir.reform (path: file: {
          path = sundry.vfs.path.set.ext "css" path;
          value =
            file
            // {
              origin =
                pkgs.runCommand "build-sass" {buildInputs = [pkgs.dart-sass];}
                "sass '${file.origin}' $out --no-source-map ${prev.sass-load-flags} --quiet";
            };
        }))
      ];
  };
}
