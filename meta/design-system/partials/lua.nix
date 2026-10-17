{mk-partial, ...}:
mk-partial {
  file-path = ["partial.lua"];
  body-fn = body:
  # -< lua >-
  ''
    return {
    ${body}
    }
  '';
  line-fn = name: value: "  [\"${name}\"] = ${value},";
}
