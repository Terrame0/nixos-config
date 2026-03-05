{
  extend-config,
  lib,
  config,
  ...
}:
extend-config "compensate-alpha-layering" (
  alpha: layer-count: let
  in
    10
)
