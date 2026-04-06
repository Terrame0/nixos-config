{
  extend-config,
  config,
  pkgs,
  lib,
  ...
}:
extend-config "directory" {
  mk-staging = drv-name: file-parameters: let
    file-data =
      lib.foldl (
        acc-attrset: file-data: let
          path-parts = lib.tail (lib.splitString "/" file-data.path);
          dest = lib.concatStringsSep "/" (lib.init path-parts);
          name = lib.last path-parts;
          path = "${dest}/${name}";
          mk-dir-cmd = "mkdir -p $out/${dest} \n";
          mk-file-cmd =
            if lib.hasAttr "src" file-data
            then "cp ${file-data.src.store-path} $out/${path} \n"
            else if lib.hasAttr "contents" file-data
            then "echo '${file-data.contents}' > $out/${path} \n"
            else "";
          cmd = mk-dir-cmd + mk-file-cmd;
        in {
          cmd = acc-attrset.str + cmd;
          paths-rel = acc-attrset.paths-rel ++ [path];
        }
      ) {
        cmd = "";
        paths-rel = [];
      }
      file-parameters;
    drv-path = pkgs.runCommand "test" {} (config.debug file-data.cmd);
    file-paths = lib.forEach file-data.paths-rel (
      file-path-rel: config.store-path.get-file "${drv-path}/${file-path-rel}"
    );
  in {
    inherit file-paths;
  };
}
