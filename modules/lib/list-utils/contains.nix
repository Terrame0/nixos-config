{extend-config, ...}:
extend-config "list" {
  contains-any = entries: list:
    builtins.any (entry: builtins.elem entry list) entries;
  contains-all = entries: list:
    builtins.all (entry: builtins.elem entry list) entries;
}
