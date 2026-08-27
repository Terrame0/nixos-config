{
  sundry,
  lib,
  mk-type,
  ...
}: {
  color = mk-type {
    value-check = value:
      lib.isString value
      && lib.match "#[0-9a-fA-F]{8}" value != null;
    rendered-values = value: let
      rgba = lib.pipe value [
        (color: offset: lib.substring (offset * 2 + 1) 2 color)
        (lib.forEach (sundry.range [4]))
        (sundry.list.zip-to-attrs ["r" "g" "b" "a"])
      ];
      inherit (rgba) r g b a;
    in {
      scss = "#${sundry.str.join [r g b a]}";
      qml = "\"#${sundry.str.join [a r g b]}\""; # -- ordering matters!
      lua = "\"#${sundry.str.join [r g b a]}\"";
      rasi = "#${sundry.str.join [r g b a]}";
    };
  };
}
