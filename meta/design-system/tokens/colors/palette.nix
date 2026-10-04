{types, ...}: let
  inherit (types) color;
in {
  palette = {
    neutral-1000 = color "#1e1c1bff";
    neutral-800 = color "#2d2b2aff";
    neutral-600 = color "#3d3b39ff";
    neutral-400 = color "#4e4b49ff";
    neutral-200 = color "#83807dff";
    neutral-0 = color "#c5c4bfff";
    red = color "#d54e53ff";
    orange = color "#e78c45ff";
    yellow = color "#e7c547ff";
    green = color "#b9ca4aff";
    aqua = color "#70c0b1ff";
    blue = color "#7aa6daff";
    purple = color "#c397d8ff";
  };
}
