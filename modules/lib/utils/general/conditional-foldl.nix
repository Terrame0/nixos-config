{
  extend-config,
  lib,
  config,
  ...
}:
extend-config "conditional-foldl" (
  value: chain:
    lib.foldl (
      result: entry: let
        condition = config.list.exclusive-head entry;
        operation = lib.last entry;
      in
        if condition == null || condition
        then operation result
        else result
    )
    value
    chain
)
