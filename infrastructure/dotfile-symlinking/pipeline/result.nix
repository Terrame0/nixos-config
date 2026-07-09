{
  sundry,
  lib,
  ...
}: {
  result = {
    deps = ["sass" "nix" "processed-imports"];
    transform = prev:
      lib.pipe prev [
        lib.attrValues
        sundry.attrs.merge.recursive.no-collision
        (sundry.vfs.dir.collapse (path: file: let
          target-path =
            sundry.vfs.tag.foldl (path-acc: tags: pos: let
              target-path-fragment = sundry.str.to-segments "|" (tags.dotfiles or "");
            in
              sundry.cond-pipe path-acc [
                [(target-path-fragment != []) (path: target-path-fragment ++ lib.drop (pos + 1) path)]
                [(tags ? ext) (path: sundry.vfs.path.set.ext tags.ext path)]
              ])
            path
            file.tag-list;
        in {
          ${sundry.vfs.path.get.str target-path} =
            (
              if file ? text
              then {text = file.text;}
              else {source = file.origin;}
            )
            # -- otherwise scripts won't be executable
            // lib.optionalAttrs (sundry.vfs.path.get.ext path == "sh") {
              executable = true;
            };
        }))
        sundry.attrs.merge.recursive.no-collision
      ];
  };
}
