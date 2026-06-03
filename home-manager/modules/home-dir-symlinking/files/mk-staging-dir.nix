{
  extend-config,
  config,
  pkgs,
  lib,
  ...
}:
extend-config "directory" {
  mk-staging-dir = file-args: let
    cmd =
      lib.foldl (
        cmd-acc: {
          path,
          src,
        }: let
          path-parts = lib.splitString "/" (lib.removePrefix "/" path);
          dest = lib.concatStringsSep "/" (lib.init path-parts);
          mk-dir-cmd = "mkdir -p $out/${dest} \n";
          cp-file-cmd = "cp ${src.store-path} $out/${path} \n";
        in
          cmd-acc + mk-dir-cmd + cp-file-cmd
      ) ""
      file-args;
    staging-dir = pkgs.runCommand "staging-directory" {} cmd;
    files = lib.forEach file-args (
      {
        path,
        src,
      }:
        src // {store-path = config.string.join-paths [staging-dir path];}
    );
  in {
    inherit files;
    inherit staging-dir;
  };
}
