{
  lib,
  extend-config,
  ...
}:
extend-config "attrset" {
  list-merge = f: lhs: rhs: let
    merged-into-lhs =
      lib.mapAttrs (
        name: list:
          f list (rhs.${name} or [])
      )
      lhs;
  in
    rhs // merged-into-lhs;
}
