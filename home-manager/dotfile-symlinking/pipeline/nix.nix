{
  sundry,
  lib,
  config,
  ...
}: {
  nix-imports = {
    deps = ["imports"];
    transform = prev:
      lib.pipe prev.imports [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
        (sundry.vfs.dir.walk (path: file:
          file
          // {
            expr = import file.origin {
              inherit config lib;
              file-dir = dirOf file.origin;
            };
          }))
      ];
  };

  nix = {
    deps = ["nix-imports"];
    transform = prev:
      lib.pipe prev.nix-imports [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
        (sundry.vfs.dir.select-by-tag (_: with _; tag {convert = ["json" "ini"];}))
        (sundry.vfs.dir.reform (
          path: file: let
            tag-value = (sundry.attrs.merge.concat file.tag-list).convert;
            generator-function = lib.generators.${"to" + (lib.toUpper tag-value)} {};
          in {
            path = sundry.vfs.path.set.ext tag-value path;
            value = file // {text = generator-function file.expr;};
          }
        ))
      ];
  };
}
