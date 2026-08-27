{
  lib,
  mk-type,
  ...
}: let
  is-number = value: lib.isInt value || lib.isFloat value;
in {
  cubic-bezier = mk-type {
    value-check = value:
      lib.isList value
      && lib.length value == 4
      && lib.all is-number value
      && lib.elemAt value 0 >= 0
      && lib.elemAt value 0 <= 1
      && lib.elemAt value 2 >= 0
      && lib.elemAt value 2 <= 1;
    rendered-values = value: let
      points = map toString value;
      x1 = lib.elemAt points 0;
      y1 = lib.elemAt points 1;
      x2 = lib.elemAt points 2;
      y2 = lib.elemAt points 3;
    in {
      scss = "cubic-bezier(${lib.concatStringsSep ", " points})";
      qml = "[${lib.concatStringsSep ", " (points ++ ["1" "1"])}]";
      lua = "{ { ${x1}, ${y1} }, { ${x2}, ${y2} } }";
      rasi = "[ ${lib.concatStringsSep ", " points} ]";
    };
  };
}
