{
  lib,
  config-add,
  ...
}:
config-add "helpers" {
  split-filepath = path: let
    path-str = lib.toString path;
    split-path = lib.splitString "/" path-str;
    split-name = lib.splitString (lib.last split-path);
    extension = lib.last split-name;
    filename = lib.concatStrings (lib.sublist 0 ((builtins.length split-name) - 1) split-name);
    specification = lib.last (lib.splitString "@" filename);
  in {
    inherit filename;
    inherit specification;
    inherit extension;
  };
}
