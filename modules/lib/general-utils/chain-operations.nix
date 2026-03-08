{
  extend-config,
  lib,
  ...
}:
extend-config "chain-operations" (
  value: operation-list:
    lib.foldl (
      result: operation:
        if lib.elemAt operation 0
        then (lib.elemAt operation 1) result
        else result
    )
    value
    operation-list
)
