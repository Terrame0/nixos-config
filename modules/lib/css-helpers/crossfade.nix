{
  config-add,
  lib,
  config,
  ...
}:
config-add "compensate-alpha-layering" (
  alpha: layer-count: let
  in
    10
)
