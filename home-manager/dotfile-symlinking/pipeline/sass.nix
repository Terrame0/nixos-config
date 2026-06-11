{
  src-path,
  mlem,
  lib,
  ...
}: {
  sass-staging = {
    deps = ["specs-stripped"];
    transform = prev:
      mlem.vfs.dir.filter
      (path: file: mlem.vfs.path.get.ext path == "scss")
      prev.specs-stripped;
  };

  sass-includes = {
  };

  sass-finalized = {
    deps = ["sass-staging"];
    transform = prev:
      lib.pipe prev.sass-staging [
        (mlem.vfs.dir.reform-by-spec {build = "sass";} (path: spec-pos: file: {
          inherit path;
          value = file;
        }))
      ];
  };

  sass-includes = {
    deps = ["sass-staging"];
    transform = prev: let
      dir = prev.sass-staging;
    in
      mlem.vfs.dir.reform-by-spec
      {i = "sass";}
      (path: spec-pos: file: {
        path =
          lib.sublist
          spec-pos
          ((lib.length path) - spec-pos)
          path;
        value = file;
      })
      dir;
  };

  result = {
    deps = ["sass-staging" "sass-finalized" "sass-includes"];
    transform = prev:
      lib.pipe prev [
        (lib.mapAttrsToList
          (name: value:
            mlem.attrs.merge.recursive.no-collision
            (mlem.vfs.dir.collapse (path: file: {
                "test-dir/${name}/${mlem.vfs.path.get.str path}".text =
                  file.contents;
              })
              value)))
        mlem.attrs.merge.recursive.no-collision
      ];
  };

  #sass-built = {
  #  scss = file: include-paths: staging-dir: let
  #  modifications = let
  #    include-flags = lib.forEach (include-paths.sass or []) (path: "--load-path='${staging-dir}/${path}'");
  #  in {
  #    extension = "css";
  #    store-path = pkgs.runCommand (file.stem + ".css") {
  #      buildInputs = [pkgs.dart-sass];
  #    } "sass ${file.store-path} $out --no-source-map --load-path='${staging-dir}' ${lib.concatStringsSep " " include-flags} --quiet";
  #  };
  #  in
  #    file // modifications;
  #};
}
