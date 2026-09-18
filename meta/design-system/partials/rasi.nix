{mk-partial, ...}:
mk-partial {
  file-path = ["partial.rasi"];
  body-fn = body:
  # -< rasi >-
  ''
    * {
    ${body}
    }
  '';
  line-fn = name: value: "  ds-${name}: ${value};";
}
