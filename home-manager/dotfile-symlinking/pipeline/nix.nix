{
  sundry,
  config-root,
  lib,
  ...
}: {
  #nix-imports = {
  #  deps = ["tags"];
  #  transform = prev:
  #    lib.pipe prev.tags [
  #      (sundry.vfs.dir.filter
  #        (path: _: sundry.vfs.path.get.ext path == "nix"))
  #      (sundry.vfs.dir.walk (path: file: let
  #        expr-src = sundry.vfs.path.get.str [file.src-dir path];
  #        expr = import expr-src;
  #      in
  #        file // {inherit expr;}))
  #    ];
  #};
  #nix-filtered = {
  #  deps = ["nix-imports"];
  #  transform = prev:
  #    lib.pipe prev.nix-imports [
  #      (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
  #      (sundry.vfs.dir.filter-by-tag {convert = ["json" "ini"];})
  #      (sundry.vfs.dir.reform (
  #        path: file: let
  #          tag-value = (sundry.attrs.merge.concat file.tag-list).convert;
  #          generator-function = lib.generators.${"to" + (lib.toUpper tag-value)} {};
  #        in {
  #          path = sundry.vfs.path.set.ext tag-value path;
  #          value = file // {text = generator-function file.text;};
  #        }
  #      ))
  #    ];
  #};
  # nix = file: let
  #   generator = lib.head (config.file.get-spec-values "form" file);
  #   generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
  #   contents =
  #     config.string.evaluate-nix
  #     (config.file.read file)
  #     {file-dir = lib.concatStringsSep "/" ([config-root] ++ file.dir-raw);};
  # in
  #   config.file.emplace (file // {extension = generator;}) (generator-function contents);
}
