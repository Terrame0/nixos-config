{
  sundry,
  lib,
  mk-type,
  ...
}: {
  color = let
    to-rgba = lib.flip lib.pipe [
      (color: offset: lib.substring (offset * 2 + 1) 2 color)
      (lib.forEach (sundry.range [4]))
      (sundry.list.zip-to-attrs ["r" "g" "b" "a"])
    ];
  in
    mk-type {
      name = "color";
      value-check = value:
        lib.isString value
        && lib.match "#[0-9a-fA-F]{8}" value != null;
      consumer-repr = value: let
        rgba = to-rgba value;
        inherit (rgba) r g b a;
      in {
        css = "#${sundry.str.join [r g b a]}";
        scss = "#${sundry.str.join [r g b a]}";
        qml = "\"#${sundry.str.join [a r g b]}\""; # -- ordering matters!
        lua = "\"#${sundry.str.join [r g b a]}\"";
        rasi = "#${sundry.str.join [r g b a]}";
      };
    };
}
