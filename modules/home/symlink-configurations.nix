{lib, ...}: let
  config-path = ./configurations;

  collect-files = base: rel: let
    dir = builtins.readDir (base + "/${rel}");
  in
    lib.concatLists (lib.mapAttrsToList
      (
        name: type: let
          newRel =
            if rel == ""
            then name
            else "${rel}/${name}";
        in
          if type == "regular"
          then [
            {
              name = newRel;
              value = {
                source = base + "/${newRel}";
                recursive = false;
              };
            }
          ]
          else if type == "directory"
          then collect-files base newRel
          else []
      )
      dir);
in {
  xdg.configFile =
    lib.listToAttrs (collect-files config-path "");
}
