{
  types,
  tokens,
  ...
}: let
  inherit (types.dimension) pt;
  inherit (types) font-family;
  inherit (tokens) palette;
in {
  font = rec {
    color = {
      primary = palette.neutral-0;
      secondary = palette.neutral-200;
      link = palette.blue;
      link-visited = palette.purple;
    };
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
    body = types.font family.propo size.body;
    h1 = types.font family.propo size.h1;
    h2 = types.font family.propo size.h2;
    h3 = types.font family.propo size.h3;
  };
}
