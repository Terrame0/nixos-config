{
  types,
  tokens,
  ...
}: let
  inherit (types.dimension) px;
  inherit (tokens) palette;
in {
  border = {
    radius = px 3;
    width = px 1;
    color = {
      L0 = palette.neutral-800;
      L1 = palette.neutral-600;
      L2 = palette.neutral-400;
    };
  };
}
