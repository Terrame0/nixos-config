{
  sundry,
  lib,
  ...
}: {
  home-files = {
    deps = ["built-sass-dotfiles" "converted-nix-dotfiles" "raw-dotfiles"];
    transform = prev:
      lib.pipe prev [
        lib.attrValues
        sundry.attrs.merge.recursive.no-collision
        (sundry.vfs.tree.collapse (path: file: let
          target-path =
            sundry.vfs.tag.foldl (path-acc: tags: pos: let
              target-path-fragment = sundry.str.to-segments "|" (tags.dotfiles or "");
            in
              sundry.cond-pipe path-acc [
                [(target-path-fragment != []) (_: target-path-fragment ++ lib.drop (pos + 1) path)]
                [(tags ? ext) (path: sundry.vfs.path.set.ext tags.ext path)]
              ])
            path
            file.tag-list;
          executable = lib.any (tags: tags ? exec) file.tag-list;
        in {
          ${sundry.vfs.path.get.str target-path} =
            (
              if file ? text
              then {inherit (file) text;}
              else {source = file.origin;}
            )
            // lib.optionalAttrs executable {
              executable = true;
            };
        }))
        sundry.attrs.merge.recursive.no-collision
      ];
  };
}
