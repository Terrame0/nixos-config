{
  lib,
  pkgs,
  ...
}: let
  config-path = ./configurations;

  collect-files = base-path: rel: let
    dir = builtins.readDir (base-path + "/${rel}");

    # -- compiles scss files to css
    scss-compiler = {src-file}: let
      name = builtins.basename src-file;
    in
      pkgs.runCommand
      {buildInputs = with pkgs; [sassc];}
      ''
        basename="${name}"
        sassc ${src-file} "${src-file}.css"
      '';
  in
    lib.concatLists (lib.mapAttrsToList (
        name: type: let
          new-relative-path =
            if rel == ""
            then name
            else "${rel}/${name}";
        in
          if type == "regular"
          then [
            {
              name = new-relative-path;
              value = {
                source = base-path + "/${new-relative-path}";
                recursive = false;
              };
            }
          ]
          else if type == "directory"
          then collect-files base-path new-relative-path
          else []
      )
      dir);
in {
  xdg.configFile = lib.listToAttrs (collect-files config-path "");
}
