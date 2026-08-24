{types, ...}: let
  font-family = types.font-family;
  inherit (types.dimension) pt;
in {
  mono = font-family "JetBrainsMono NF";
  propo = font-family "JetBrainsMono NFP";
  h1 = pt 17;
  h2 = pt 14;
  h3 = pt 11;
}
