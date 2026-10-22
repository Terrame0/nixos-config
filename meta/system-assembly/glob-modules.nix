args @ {
  host,
  sundry,
  lib,
  inputs,
  root,
  flake-file-tree,
  ...
}: let
  assert-unique-stems = files: let
    stems =
      map (
        file: let
          file-str = toString file;
        in
          if baseNameOf file-str == "default.nix"
          then dirOf file-str
          else lib.removeSuffix ".nix" file-str
      )
      files;
    duplicates =
      lib.unique (lib.filter (stem: lib.count (candidate: candidate == stem) stems > 1) stems);
  in
    if duplicates == []
    then true
    else
      throw ''
        module discovery found both `<name>.nix` and `<name>/default.nix`:
        ${lib.concatMapStringsSep "\n" (stem: "  ${stem}") duplicates}

        delete the stale file so both copies cannot drift.
      '';

  filter-modules = tag-value:
    lib.pipe flake-file-tree.src [
      (sundry.vfs.dir.filter
        (path: file: sundry.vfs.path.get.ext path == "nix"))
      (sundry.vfs.dir.select-by-tag
        (e:
          (e.tag {modules = [];})
          && !(e.tag {private = [];} || e.tag {dotfiles = [];})
          && (e.deepest-tag {hosts = host.name;} || !e.tag {hosts = [];})))
      (sundry.vfs.dir.select-by-tag (e: e.deepest-tag {modules = tag-value;}))
      (sundry.vfs.dir.collapse (path: file: file.origin))
    ];
  module-args = {
    inherit (args) inputs host root sundry flake-file-tree design-tokens;
  };
  system-modules = filter-modules "system";
  user-modules = filter-modules "user";
in {
  specialArgs = module-args;
  modules = assert assert-unique-stems (system-modules ++ user-modules);
    system-modules
    ++ [
      {
        home-manager = {
          extraSpecialArgs = module-args;
          users.${host.username}.imports = user-modules;
        };
      }
    ];
}
