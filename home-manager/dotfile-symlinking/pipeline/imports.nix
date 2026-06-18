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
  tags-stripped = {
    deps = ["imports"];
    transform = prev:
      mlem.vfs.dir.resolve-tags
      {strip = true;}
      prev.imports;
  };
  tags = {
    deps = ["imports"];
    transform = prev:
      mlem.vfs.dir.resolve-tags
      {strip = false;}
      prev.imports;
  };
}
