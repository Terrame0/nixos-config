{mk-partial, ...}:
mk-partial {
  file-path = ["partial.css"];
  body-fn = body:
  # -< css >-
  ''
    :root {
    ${body}
    }
  '';
  line-fn = name: value: "  --ds-${name}: ${value};";
}
