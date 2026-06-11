{
  mlem,
  flake-root,
  ...
}: {
  imports = {
    transform = _:
      mlem.vfs.dir.from-src
      "${flake-root}/home-manager/dotfile-symlinking/src";
  };
  specs-stripped = {
    deps = ["imports"];
    transform = prev:
      mlem.vfs.dir.resolve-specs
      {
        strip = true;
        separators = ["[" ":" "," "]"];
      }
      prev.imports;
  };
  specs = {
    deps = ["imports"];
    transform = prev:
      mlem.vfs.dir.resolve-specs
      {
        strip = false;
        separators = ["[" ":" "," "]"];
      }
      prev.imports;
  };
}
