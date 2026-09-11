args @ {
  sundry,
  lib,
  pkgs,
  host,
  ...
}: {
  evaluated-nix-dotfiles = {
    deps = ["dotfile-sources"];
    transform = prev:
      lib.pipe prev.dotfile-sources [
        (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
        (sundry.vfs.dir.load-nix-with
          (path: file: expr: expr (args // {file-dir = dirOf file.origin;})))
      ];
  };

  converted-nix-dotfiles = {
    deps = ["evaluated-nix-dotfiles"];
    transform = prev:
      lib.pipe prev.evaluated-nix-dotfiles [
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
