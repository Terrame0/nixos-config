{
  lib,
  pkgs,
  ...
}: {}
# let
#   # -- compiles scss files into css
#   compile-scss = src-file-path: let
#     out-file-name = lib.replaceStrings [".scss"] [".css"] (builtins.baseNameOf src-file-path);
#     store-path = pkgs.runCommand out-file-name {
#       buildInputs = with pkgs; [sassc];
#     } "sassc ${src-file-path} $out";
#   in {
#     inherit store-path;
#     file-name = out-file-name;
#   };
#
#   # -- path to the folder in the nix configuration
#   # that is being symlinked against
#   nix-config-path = ./configurations;
#
#   # -- a recursive function that walks the directory
#   # and mirrors the file structure of the
#   # nix-config-path directory into the ~/.config/ directory
#   # (by creating symlinks)
#   collect-files = base-path: prev-relative-path: let
#     dir = builtins.readDir (base-path + "/${prev-relative-path}");
#   in
#     # -- creates a big list from all the return values of the recursive function
#     builtins.concatLists (
#       # -- collapses the {dir=type;...} attrset into a list of files [file-path ...] that are symlinked
#       lib.mapAttrsToList (
#         current-path: path-type: let
#           relative-path = builtins.concatStringsSep "/" (
#             builtins.filter (str: str != "") [
#               prev-relative-path
#               current-path
#             ]
#           );
#         in
#           assert !(lib.hasPrefix "/" relative-path);
#           # -- if the path points to a file, we add it to the xdg.configFile
#             if path-type == "regular"
#             then [
#               (
#                 let
#                   file-data =
#                     if lib.hasSuffix ".scss" (builtins.baseNameOf relative-path)
#                     then let
#                       compiled-css = compile-scss (base-path + "/${relative-path}");
#                     in {
#                       config-path = builtins.concatStringsSep "/" (
#                         builtins.filter (str: str != "") [
#                           prev-relative-path
#                           compiled-css.file-name
#                         ]
#                       );
#                       source-path = compiled-css.store-path;
#                     }
#                     else {
#                       config-path = relative-path;
#                       source-path = base-path + "/${relative-path}";
#                     };
#                 in {
#                   name = file-data.config-path;
#                   value = {
#                     source = file-data.source-path;
#                   };
#                 }
#               )
#             ]
#             else if path-type == "directory"
#             then collect-files base-path relative-path
#             else []
#       )
#       dir
#     );
# in {
#   xdg.configFile = builtins.listToAttrs (collect-files nix-config-path "");
# }

