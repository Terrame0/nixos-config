{mk-partial, ...}:
mk-partial {
  file-path = ["partial.rasi"];
  body-fn = body: ''
    * {
    ${body}
    }
  '';
  line-fn = name: value: "  ds-${name}: ${value};";
}
