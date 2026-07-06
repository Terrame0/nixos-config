{
  sundry,
  lib,
  ...
}: let
  to-home-path = path: file:
    sundry.vfs.file.fold-tags (path-acc: tags: pos: let
      path-fragment = sundry.str.to-segments "|" (tags.dotfiles or "");
    in
      if path-fragment == []
      then path-acc
      else path-fragment ++ lib.drop (pos + 1) path-acc)
    path
    file;
in {
  result = {
    deps = ["sass" "nix" "processed-imports"];
    transform = prev:
      lib.pipe prev [
        lib.attrValues
        sundry.attrs.merge.recursive.no-collision
        (sundry.vfs.dir.reform-within-tag
          (_: with _; tag {ext = [];})
          (path: file: {
            path = sundry.vfs.path.set.ext (lib.last file.tag-list).ext path;
            value = file;
          }))
        (sundry.vfs.dir.collapse (path: file: {
          ${sundry.vfs.path.get.str (to-home-path path file)} =
            (
              if file ? text
              then {text = file.text;}
              else {source = file.origin;}
            )
            # -- otherwise the scripts won't be executable
            // lib.optionalAttrs (sundry.vfs.path.get.ext path == "sh") {
              executable = true;
            };
        }))
        sundry.attrs.merge.recursive.no-collision
      ];
  };
}
