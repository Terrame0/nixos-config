{
  extend-config,
  lib,
  ...
}:
extend-config "debug" (value: lib.traceValSeq value)
