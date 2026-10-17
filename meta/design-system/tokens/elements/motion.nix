{types, ...}: let
  inherit (types) cubic-bezier;
in {
  motion.easing = {
    standard = cubic-bezier [0.8 0 0.2 1];
    overshoot = cubic-bezier [0.8 0 0.2 1.1];
    out = cubic-bezier [0.6 0.5 0.2 1];
  };
}
