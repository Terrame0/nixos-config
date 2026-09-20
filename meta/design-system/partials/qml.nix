{mk-partial, ...}:
mk-partial {
  file-path = ["partial.qml"];
  body-fn = body:
  # -< qml >-
  ''
    :root {
    ${body}
    }
  '';
  line-fn = name: value: "  --ds-${name}: ${value};";
}
