{
  lib,
  pkgs,
  ...
}:
let
  config-path = ./configurations;
  collect-files =
    base-path: rel:
    let
      dir = builtins.readDir (base-path + "/${rel}");
      compile-scss =
        { src-file }:
        let
          base = lib.basename src-file;
          name = lib.replaceStrings [ ".scss" ] [ ".css" ] base;
        in
        pkgs.runCommand name { buildInputs = with pkgs; [ sassc ]; } "sassc ${src-file} $out";
    in
    lib.concatLists (
      lib.mapAttrsToList (
        name: type:
        let
          file-or-dir-path = if rel == "" then name else "${rel}/${name}";
          file-path = file-or-dir-path; # -- just for clarity --
          dir-path = file-or-dir-path; # -----------------------
        in
        if type == "regular" then
          [
            (
              let
                a = 10;
              in
              {
                name = file-path;
                value = {
                  source = base-path + "/${file-path}";
                  recursive = false;
                };
              }
            )
          ]
        else if type == "directory" then
          collect-files base-path dir-path
        else
          [ ]
      ) dir
    );
in
{
  xdg.configFile = lib.listToAttrs (collect-files config-path "");
}
