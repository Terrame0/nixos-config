{
  sundry,
  lib,
  mk-partial,
  ...
}: let
  tokens-file = mk-partial {
    file-path = ["DesignTokens" "DesignTokens.qml"];
    name-fn = path:
      "ds_" + lib.replaceStrings ["-"] ["_"] (sundry.str.join-with "_" path);
    body-fn = body:
    # -< qml >-
    ''
      pragma Singleton
      import QtQuick

      QtObject {
      ${body}
      }
    '';
    line-fn = name: value: "  readonly property var ${name}: ${value}";
  };
in
  sundry.attrs.merge.recursive.no-collision [
    tokens-file
    (sundry.vfs.file.from-text ["DesignTokens" "qmldir"]
      # -< qml module >-
      ''
        module DesignTokens
        singleton DesignTokens 1.0 DesignTokens.qml
      '')
  ]
