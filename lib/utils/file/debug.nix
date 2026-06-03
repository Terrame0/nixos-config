{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "file" {
  debug = file: let
    spec-strs = lib.forEach file.specs (
      spec: "(${toString spec.index}) ${spec.name}:${spec.value}"
    );

    debug-string =
      config.debug
      "\n    [ === ${file.stem}.${file.extension} === ]
    [ path-str: ${config.file.path-str file} ]
    [ raw-stem: ${file.stem-raw} ] [ ext: ${file.extension} ]
    [ raw-dir: ${lib.concatStringsSep " | " file.dir-raw} ] 
    [ specs: ${
        if spec-strs != []
        then lib.concatStringsSep " | " spec-strs
        else "none"
      } ]";
  in
    file // {inherit debug-string;};
}
