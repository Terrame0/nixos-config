{
  root,
  inputs,
}: f:
builtins.foldl' (
  attrs-acc: host: let
    pkgs = import inputs.nixpkgs {inherit (host) system;};
    pkgs-unstable = import inputs.nixpkgs-unstable {inherit (host) system;};
    inherit (pkgs) lib;
    sundry = let
      base = import inputs.sundry-flake {
        inherit pkgs;
        config = {
          vfs.tags = {
            lsep = "[";
            rsep = "]";
          };
        };
      };
      # - sundry's get-relative-to strips only `{}` from a literal's segments;
      # - a literal's ancestors keep their on-disk `[…]` tags, so strip those first.
      normalize = path-str:
        lib.concatStringsSep "/"
        (map (segment: lib.concatStringsSep "" (base.vfs.path.strip-between "[" "]" [segment]))
          (lib.splitString "/" path-str));
    in
      base
      // {
        vfs =
          base.vfs
          // {
            tree =
              base.vfs.tree
              // {
                get-relative-to = root: path: tree:
                  base.vfs.tree.get-relative-to root
                  (
                    if lib.isPath path || lib.isString path
                    then normalize (toString path)
                    else path
                  )
                  tree;
              };
          };
      };
    flake-file-tree = lib.pipe root [
      sundry.vfs.tree.from-src
      sundry.vfs.tree.load-nix
      sundry.vfs.tree.resolve-tags
    ];
    design-system =
      flake-file-tree.meta.design-system."default.nix".expr
      {inherit sundry lib flake-file-tree;};
    design-tokens = design-system.native-tokens;
    meta-args = {
      inherit host inputs root;
      inherit pkgs pkgs-unstable;
      inherit sundry lib;
      inherit design-tokens;
      flake-file-tree =
        lib.pipe [
          {"partials[dot:.design-system]" = design-system.partials-file-tree;}
        ] [
          (map sundry.vfs.tree.resolve-tags)
          (lib.foldl sundry.vfs.tree.merge flake-file-tree)
        ];
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)
