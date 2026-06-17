{
  mlem,
  config-root,
  ...
}: {
  imports = {
    transform = _:
      mlem.vfs.dir.from-src
      "${config-root}/home-manager/dotfile-symlinking/src";
  };
  specs-stripped = {
    deps = ["imports"];
    transform = prev:
      mlem.vfs.dir.resolve-specs
      {strip = true;}
      prev.imports;
  };
  specs = {
    deps = ["imports"];
    transform = prev:
      mlem.vfs.dir.resolve-specs
      {strip = false;}
      prev.imports;
  };
}
