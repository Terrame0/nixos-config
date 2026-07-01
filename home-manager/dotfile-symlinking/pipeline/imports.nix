{
  sundry,
  config-root,
  ...
}: {
  imports = {
    transform = _:
      sundry.vfs.dir.from-src "${config-root}/home-manager/dotfile-symlinking/src";
  };
  tags-stripped = {
    deps = ["imports"];
    transform = prev:
      sundry.vfs.dir.resolve-tags
      prev.imports;
  };
}
