{tokens, ...}: let
  inherit (tokens) palette;
in {
  surface = {
    L0 = palette.neutral-1000;
    L1 = palette.neutral-800;
    L2 = palette.neutral-600;
  };
}
