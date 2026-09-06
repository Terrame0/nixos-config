{mk-partial, ...}:
mk-partial {
  file-path = ["partial{include:sass}.scss"];
  line-fn = name: value: "\$${name}: ${value};";
}
