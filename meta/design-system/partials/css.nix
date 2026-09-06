{mk-partial, ...}:
mk-partial {
  file-path = ["partial.css"];
  body-fn = body: ''
    :root {
    ${body}
    }
  '';
  line-fn = name: value: "  --ds-${name}: ${value};";
}
