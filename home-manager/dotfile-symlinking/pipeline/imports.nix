{
  sundry,
  config-root,
  lib,
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
      {strip = true;}
      prev.imports;
  };
  tags = {
    deps = ["imports"];
    transform = prev:
      sundry.vfs.dir.resolve-tags
      {strip = false;}
      prev.imports;
  };
}
