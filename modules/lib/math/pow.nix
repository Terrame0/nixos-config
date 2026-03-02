{config-add, ...}:
config-add "math"
(let
  pow = x: depth:
    if depth == 1
    then x
    else x * pow x (depth - 1);
in {
  inherit pow;
})
