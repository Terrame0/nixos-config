{types, ...}: let
  font-family = types.font-family;
  inherit (types.dimension) pt;
in rec {
  family = {
    mono = font-family "JetBrainsMono NF";
    propo = font-family "JetBrainsMono NFP";
  };
  size = {
    body = pt 16;
    h1 = pt 17;
    h2 = pt 14;
    h3 = pt 11;
  };
  font = {
    inherit family size;
    body = types.font family.propo size.body;
    h1 = types.font family.propo size.h1;
    h2 = types.font family.propo size.h2;
    h3 = types.font family.propo size.h3;
  };
}
