{
  lib,
  pkgs,
  config-add,
  ...
}:
config-add "fns"
{
  compile-scss = file-data: let
    file-path = lib.concatStringsSep "/" (file-data.file-dir + [(file-data.file-name + file-data.extension)]);
    store-path = pkgs.runCommand file-path {
      buildInputs = with pkgs; [sassc];
    } "sassc ${file-data.store-path} $out";
  in {
    inherit store-path;
    full-path = file-data.full-path;
    extension = "scss";
  };
}
