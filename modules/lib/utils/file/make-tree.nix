{
  extend-config,
  config,
  pkgs,
  lib,
  ...
}:
extend-config "file" {
  make-tree = drv-name: file-data-list: let
    command-str =
      lib.foldl (
        command-str-acc: file-data: let
          path-parts = lib.tail (lib.splitString "/" file-data.path);
          dest = lib.concatStringsSep "/" (lib.init path-parts);
          name = lib.last path-parts;
          path = dest + "/" + name;
          make-dir-cmd = "mkdir -p $out/${dest} \n";

          make-file-cmd =
            if lib.hasAttr "copy-src" file-data
            then "cp ${file-data.copy-src.store-path} $out/${path} \n"
            else if lib.hasAttr "contents" file-data
            then "echo '${file-data.contents}' > $out/${path} \n"
            else "";
          full-cmd = make-dir-cmd + make-file-cmd;
        in
          command-str-acc + full-cmd
      ) ""
      file-data-list;
  in
    config.debug command-str;
}
