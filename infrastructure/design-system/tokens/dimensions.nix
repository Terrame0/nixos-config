{types, ...}: let
  inherit (types.dimension) px;
in {
  double-offset = px 12;
  offset = px 6;
  border-radius = px 12;
}
