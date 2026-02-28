{
  config-add,
  lib,
  ...
}:
config-add "debug" (value: lib.traceValSeq value)
