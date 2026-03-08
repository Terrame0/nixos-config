{
  extend-config,
  config,
  ...
}:
extend-config "string" {
  split-to-attrs = sep: string: {
    name = config.string.before sep string;
    value = config.string.after sep string;
  };
}
