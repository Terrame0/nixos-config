{mk-partial, ...}:
mk-partial {
  file-path = ["partial[i:sass].scss"];
  line-fn = name: value: "\$${name}: ${value};";
}
