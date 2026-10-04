{types, ...}: let
  inherit (types.dimension) px;
in {
  grid = {
    spacing = px 4;
    step = {
      large = px 90;
      regular = px 60;
      fine = px 40;
    };
  };
}
