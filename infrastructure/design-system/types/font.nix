{
  lib,
  mk-type,
  is-token,
  ...
}: let
  mk-font = mk-type {
    name = "font";
    value-check = value:
      lib.isAttrs value
      && value ? family
      && value ? size
      && is-token [] value.family
      && is-token [] value.size
      && value.family.type == "font-family"
      && value.size.type == "dimension.pt";
    rendered-values = value: let
      inherit (value) family size;
    in {
      scss = "${size.to.scss} ${family.to.scss}";
      qml = "Qt.font({ family: ${family.to.qml}, pointSize: ${size.to.qml} })";
      lua = "{ family = ${family.to.lua}, size = ${size.to.lua} }";
      rasi = "\"${family.value} ${size.to.rasi}\"";
    };
  };
in {
  font = family: size: mk-font {inherit family size;};
}
